//
//  ArchivalMenu.swift
//  DerTermin
//
//  Created by Алексей Хурсевич on 13.02.24.
//

import Foundation
import SwiftUI
import CoreData

struct Presets: View {
    public static func reloadByLanguage(_ languagePrefix: String, in context: NSManagedObjectContext){
        print("Presets.reloadByLanguage: languagePrefix: \(languagePrefix)")
        let fileDirectory: URL? = Bundle.main.resourceURL
        if let presetFiles = Bundle.main.urls(forResourcesWithExtension: "gtpres", subdirectory: nil) {
            for fileURL in presetFiles.sorted{$0.lastPathComponent < $1.lastPathComponent}.filter{$0.lastPathComponent.starts(with: languagePrefix)} {
                //listOfFiles.append(fileURL.lastPathComponent)
                let childContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                childContext.parent = context
                childContext.automaticallyMergesChangesFromParent = false
                print("Preset: Start preset loading for \(fileURL.lastPathComponent)")
                childContext.performAndWait{
                    Data_Archival(theFile: fileDirectory!.appendingPathComponent(fileURL.lastPathComponent), theContext: childContext).preset()
                }
                //Settings.setLocale(language, in: childContext)
                print("Preset: Start final context save")
                childContext.performAndWait{
                    do{
                        try childContext.save()
                    }catch{}
                }
                context.performAndWait {
                    do{
                        try context.save()
                    }catch{}
                }
                print("Preset: Invocation of saves completed")
            }
        }
    }
    
    @AppStorage("appLanguage") var language: String = "ru"
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var theme: ThemeManager
    
    @State var listOfFiles: [String] = []
    @State var reloadInvokation: Int = 0
    @State var fileDirectory: URL? = nil
    
    @State var showRemovalConfirmaton: Bool = false
    @State var showRestorationConfirmation: Bool = false
    @State var showFlushConfirmaton: Bool = false
    
    @State var fileSelectorForHovers: String = ""
    
    @State var isSaving: Bool = false
    @State var isLoading: Bool = false
    @State var isFlushing: Bool = false
    
    @State var SavingDispatchQueue = DispatchQueue(label: "Presets.loadingQueue")
    @State var hideBackButton: Bool = false
    
    var body: some View{
        ZStack{

            VStack{
                ZStack{
                    VStack{
                        HStack{
                            Spacer()
                            NG_Button(title: "Flush all data", style: .NG_ButtonStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {showFlushConfirmaton = true})
                                .padding(.horizontal)
                        }
                        List{
                            ForEach(listOfFiles, id:\.self){ theFile in
                                HStack{
                                    ScrollView(.horizontal){
                                        Text("\(theFile)")
                                            .NG_textStyling(.NG_TextStyle_Color_ListRow_Second, noShadow: true, theme: theme)
                                    }
                                    Spacer()
                                    Image(systemName: "square.and.arrow.up.circle")
                                        .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                        .onTapGesture{
                                            fileSelectorForHovers = theFile
                                            showRestorationConfirmation = true
                                        }
                                }
                                .listRowBackground(theme.currentTheme.NG_LinearGradient_Background_ListRow_Second_Regular)
                                .listRowSeparatorTint(theme.currentTheme.NG_Color_ListRow_Separator)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .listStyle(.inset)
                        .id(reloadInvokation)
                        //.shadow(color: Color.cardShadow, radius: 10, x: 0, y: 4)
                    }
                }
            }
            .onAppear(perform: reloadListOfFiles)
            .disabled(showRemovalConfirmaton||showRestorationConfirmation||isSaving||isLoading)
            .blur(radius: showRemovalConfirmaton||showRestorationConfirmation||isSaving||isLoading ? 1 : 0)
             
            if(showRestorationConfirmation){
                VStack{
                    Text("This opearation will merge preset into current data. What means that the current data will be expanded with the data from the preset. Do you want to make a backup of existing data before the preset processing?".localized(for: language))
                        .NG_textStyling(.NG_TextStyle_Text_Regular, .NG_TextColor_Red, theme: theme)
                        .padding(10)
                    VStack{
                        NG_Button(title: "Archive before load".localized(for: language), style: .NG_ButtonStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                            hideBackButton = true
                            isSaving = true
                            SavingDispatchQueue.async {
                                let childContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                                childContext.parent = PersistenceController.shared.container.viewContext
                                childContext.automaticallyMergesChangesFromParent = false
                                Data_Archival(theFile: fileDirectory!.appendingPathComponent("archive_"+Date.convert_DateToString_DownToSecond(theDate: Date())+".gharch"), theContext: childContext).dump()
                                DispatchQueue.main.sync {
                                    reloadListOfFiles()
                                    isSaving = false
                                    isLoading = true
                                }
                                childContext.performAndWait{
                                    Data_Archival(theFile: fileDirectory!.appendingPathComponent(fileSelectorForHovers), theContext: childContext).preset()
                                }
                                Settings.setLocale(language, in: childContext)
                                childContext.performAndWait{
                                    do{
                                        try childContext.save()
                                    }catch{}
                                }
                                viewContext.performAndWait{
                                    do{
                                        try viewContext.save()
                                    }catch{}
                                }
                                DispatchQueue.main.sync {
                                    reloadListOfFiles()
                                    isLoading = false
                                    hideBackButton = false
                                }
                            }
                            showRestorationConfirmation = false
                        }, widthFlood: true)
                        NG_Button(title: "Load and modify current data".localized(for: language), style: .NG_ButtonStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                            hideBackButton = true
                            isLoading = true
                            SavingDispatchQueue.async {
                                let childContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                                childContext.parent = PersistenceController.shared.container.viewContext
                                childContext.automaticallyMergesChangesFromParent = false
                                print("Preset: Start preset loading")
                                childContext.performAndWait{
                                    Data_Archival(theFile: fileDirectory!.appendingPathComponent(fileSelectorForHovers), theContext: childContext).preset()
                                }
                                Settings.setLocale(language, in: childContext)
                                print("Preset: Start final context save")
                                childContext.performAndWait{
                                    do{
                                        try childContext.save()
                                    }catch{}
                                }
                                viewContext.performAndWait {
                                    do{
                                        try viewContext.save()
                                    }catch{}
                                }
                                print("Preset: Invocation of saves completed")
                                DispatchQueue.main.sync {
                                    reloadListOfFiles()
                                    isLoading = false
                                    hideBackButton = false
                                }
                            }
                            showRestorationConfirmation = false
                        }, widthFlood: true)
                        NG_Button(title: "Cancel".localized(for: language), style: .NG_ButtonStyle_Regular, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                            showRestorationConfirmation = false
                        }, widthFlood: true)
                    }
                }
                //.cardStyle(backgroundColor: .cardBackground, shadowColor: .cardShadow, borderDark: .cardBorderDark, borderBright: .cardBorderBright)
                .NG_Card(.NG_CardStyle_Regular, theme: theme)
                .padding(.horizontal)
            }
            
            if(showFlushConfirmaton){
                VStack{
                    Text("This opearation will erase all current data. What means that the current data will be lost with no undo option. Do you want to make a backup of existing data before the flush?".localized(for: language))
                        .NG_textStyling(.NG_TextStyle_Text_Regular, .NG_TextColor_Red, theme: theme)
                        .padding(10)
                    VStack{
                        NG_Button(title: "Archive before flush".localized(for: language), style: .NG_ButtonStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                            hideBackButton = true
                            isSaving = true
                            SavingDispatchQueue.async {
                                let childContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                                childContext.parent = PersistenceController.shared.container.viewContext
                                childContext.automaticallyMergesChangesFromParent = false
                                Data_Archival(theFile: fileDirectory!.appendingPathComponent("archive_"+Date.convert_DateToString_DownToSecond(theDate: Date())+".gharch"), theContext: childContext).dump()
                                DispatchQueue.main.sync {
                                    reloadListOfFiles()
                                    isSaving = false
                                    isFlushing = true
                                }
                                Data_Archival(theFile: fileDirectory!.appendingPathComponent(fileSelectorForHovers), theContext: childContext).flush()
                                Settings.setLocale(language, in: childContext)
                                do{
                                    try childContext.save()
                                    try viewContext.save()
                                }catch{}
                                DispatchQueue.main.sync {
                                    reloadListOfFiles()
                                    isFlushing = false
                                    hideBackButton = false
                                }
                            }
                            showFlushConfirmaton = false
                        }, widthFlood: true)
                        NG_Button(title: "Flush and loose current data".localized(for: language), style: .NG_ButtonStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                            hideBackButton = true
                            isFlushing = true
                            SavingDispatchQueue.async {
                                let childContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                                childContext.parent = PersistenceController.shared.container.viewContext
                                childContext.automaticallyMergesChangesFromParent = false
                                Data_Archival(theFile: fileDirectory!.appendingPathComponent(fileSelectorForHovers), theContext: childContext).flush()
                                Settings.setLocale(language, in: childContext)
                                do{
                                    try childContext.save()
                                    try viewContext.save()
                                }catch{}
                                DispatchQueue.main.sync {
                                    reloadListOfFiles()
                                    isFlushing = false
                                    hideBackButton = false
                                }
                            }
                            showFlushConfirmaton = false
                        }, widthFlood: true)
                        NG_Button(title: "Cancel".localized(for: language), style: .NG_ButtonStyle_Regular, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                            showFlushConfirmaton = false
                        }, widthFlood: true)
                    }
                }
                //.cardStyle(backgroundColor: .cardBackground, shadowColor: .cardShadow, borderDark: .cardBorderDark, borderBright: .cardBorderBright)
                .NG_Card(.NG_CardStyle_Regular, theme: theme)
                .padding(.horizontal)
            }
            
            if(isLoading){
                VStack{
                    Text("DATA LOAD IS IN PROGRESS...".localized(for: language))
                        .NG_textStyling(.NG_TextStyle_Text_Regular, .NG_TextColor_Green, theme: theme)
                        .padding()
                }
                .NG_Card(.NG_CardStyle_Green, theme: theme)
                .padding(.horizontal)
            }
            
            if(isFlushing){
                VStack{
                    Text("DATA FLUSH IS IN PROGRESS...".localized(for: language))
                        .NG_textStyling(.NG_TextStyle_Text_Regular, .NG_TextColor_Red, theme: theme)
                        .padding()
                }
                .NG_Card(.NG_CardStyle_Red, theme: theme)
                .padding(.horizontal)
            }
        }
        .background(theme.currentTheme.NG_LinearGradient_Background_Page)
        .navigationBarBackButtonHidden(true)
        .if(!hideBackButton){ view in
            view.navigationBarItems(
                leading: /*Button(action: {
                    dismiss()
                }) {*/
                    BackButton(action: {
                        dismiss()
                    })
                //}
            )
        }
    }
    private func reloadListOfFiles(){
        fileDirectory = Bundle.main.resourceURL
        listOfFiles.removeAll()
        if let presetFiles = Bundle.main.urls(forResourcesWithExtension: "gtpres", subdirectory: nil) {
            for fileURL in presetFiles.sorted{$0.lastPathComponent < $1.lastPathComponent}.filter{$0.lastPathComponent.starts(with: LocaleView.LocaleItem.filePrefix(for: language))} {
                listOfFiles.append(fileURL.lastPathComponent)
            }
        } else {
            print("Файлы .gtpres не найдены в bundle")
        }
        reloadInvokation += 1
    }
    func copyPresetsIfNeeded() {
        let fileManager = FileManager.default

        // Папка назначения в Documents/Presets
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let presetsFolderURL = documentsURL.appendingPathComponent("Presets")
        
        // Создаём папку, если её ещё нет
        if !fileManager.fileExists(atPath: presetsFolderURL.path) {
            try? fileManager.createDirectory(at: presetsFolderURL, withIntermediateDirectories: true)
        }
        
        // Путь к папке Presets в bundle
        guard let bundlePresetsURL = Bundle.main.resourceURL?.appendingPathComponent("Presets") else {
            print("Папка Presets не найдена в bundle")
            return
        }

        do {
            let presetFiles = try fileManager.contentsOfDirectory(at: bundlePresetsURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for fileURL in presetFiles where fileURL.pathExtension == "gtpres" {
                let destinationURL = presetsFolderURL.appendingPathComponent(fileURL.lastPathComponent)
                
                if !fileManager.fileExists(atPath: destinationURL.path) {
                    try fileManager.copyItem(at: fileURL, to: destinationURL)
                    print("Скопирован: \(fileURL.lastPathComponent)")
                } else {
                    print("Файл уже есть: \(fileURL.lastPathComponent)")
                }
            }
        } catch {
            print("Ошибка при копировании пресетов: \(error)")
        }
    }
}
