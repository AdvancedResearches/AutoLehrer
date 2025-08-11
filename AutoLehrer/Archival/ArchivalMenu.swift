//
//  ArchivalMenu.swift
//  DerTermin
//
//  Created by Алексей Хурсевич on 13.02.24.
//

import Foundation
import SwiftUI
import CoreData

struct ArchivalMenu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @AppStorage("appLanguage") var language: String = "ru"
    @EnvironmentObject var theme: ThemeManager
    @EnvironmentObject var recommendationModel: RecommendationModel
    @EnvironmentObject var presetsProgress: PresetsProgressOO
    
    @State var listOfFiles: [String] = []
    @State var reloadInvokation: Int = 0
    @State var fileDirectory: URL? = nil
    
    @State var showRemovalConfirmaton: Bool = false
    @State var showRestorationConfirmation: Bool = false
    @State var showResetConfirmaton: Bool = false
    
    @State var fileSelectorForHovers: String = ""
    
    @State var isSaving: Bool = false
    @State var isLoading: Bool = false
    @State var isFlushing: Bool = false
    
    @State var SavingDispatchQueue = DispatchQueue(label: "ArchivalMenu.savingQueue")
    @State var hideBackButton: Bool = false
    
    var body: some View{
        ZStack{
            VStack{
                ZStack{
                    VStack{
                        HStack{
                            NG_Button(title: "Create archive".localized(for: language), style: .NG_ButtonStyle_Regular, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                                hideBackButton = true
                                isSaving = true
                                SavingDispatchQueue.async{
                                    let childContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                                    childContext.parent = PersistenceController.shared.container.viewContext
                                    childContext.automaticallyMergesChangesFromParent = false
                                    Data_Archival(theFile: fileDirectory!.appendingPathComponent("archive_"+Date.convert_DateToString_DownToSecond(theDate: Date())+".gharch"), theContext: childContext).dump()
                                    DispatchQueue.main.sync {
                                        reloadListOfFiles()
                                        isSaving = false
                                        hideBackButton = false
                                    }
                                }
                            })
                            .padding(.leading)
                            Spacer()
                            NG_Button(title: "Reset".localized(for: language), style: .NG_ButtonStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false),action: {
                                showResetConfirmaton = true
                            })
                            .padding(.trailing)
                        }
                        List{
                            ForEach(listOfFiles, id:\.self){ theFile in
                                HStack{
                                    ScrollView(.horizontal){
                                        Text("\(theFile)")
                                            .NG_textStyling(.NG_TextStyle_Color_ListRow_Second, noShadow: true, theme: theme)
                                    }
                                    Spacer()
                                    Image(systemName: "trash.circle")
                                        .NG_iconStyling(.NG_IconStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                        .onTapGesture {
                                            fileSelectorForHovers = theFile
                                            showRemovalConfirmaton = true
                                        }
                                    Image(systemName: "square.and.arrow.up.circle")
                                        .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(true), isPulsating: .constant(false), theme: theme)
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
                    }
                }
            }
            .onAppear(perform: reloadListOfFiles)
            .background(theme.currentTheme.NG_LinearGradient_Background_Page)//MasterColorSchema.mainBackground)
            .disabled(showRemovalConfirmaton||showRestorationConfirmation||isSaving||isLoading)
            .blur(radius: showRemovalConfirmaton||showRestorationConfirmation||isSaving||isLoading ? 1 : 0)
            
            if(showRemovalConfirmaton){
                VStack{
                    Text("This opearation will cause the file removal. No restoration is available. Are you sure?".localized(for: language))
                        .NG_textStyling(.NG_TextStyle_Text_Regular, .NG_TextColor_Red, theme: theme)
                        .padding(10)
                    VStack{
                        NG_Button(title: "Remove".localized(for: language), style: .NG_ButtonStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                            let thePath = fileDirectory!.appendingPathComponent(fileSelectorForHovers)
                            do{try FileManager.default.removeItem(at: thePath)}catch let Error{ print("\(Error)")}
                            showRemovalConfirmaton = false
                            reloadListOfFiles()
                        }, widthFlood: true)
                        NG_Button(title: "Cancel".localized(for: language), style: .NG_ButtonStyle_Regular, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                            showRemovalConfirmaton = false
                        }, widthFlood: true)
                    }
                }
                .NG_Card(.NG_CardStyle_Regular, theme: theme)
                .padding(.horizontal)
            }
            
            if(showRestorationConfirmation){
                VStack{
                    Text("This opearation will cause overwrite of current data with the one stored in archive file. What means that the current data will be lost with no undo option. Do you want to make a backup of existing data before the restoration of the archive?".localized(for: language))
                        .NG_textStyling(.NG_TextStyle_Text_Regular, .NG_TextColor_Red, theme: theme)
                        .padding(10)
                    VStack{
                        NG_Button(title: "Archive before restore".localized(for: language), style: .NG_ButtonStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
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
                                Data_Archival(theFile: fileDirectory!.appendingPathComponent(fileSelectorForHovers), theContext: childContext).restore()
                                do{
                                    try childContext.save()
                                    try viewContext.save()
                                }catch{}
                                DispatchQueue.main.sync {
                                    reloadListOfFiles()
                                    isLoading = false
                                    hideBackButton = false
                                }
                            }
                            showRestorationConfirmation = false
                        }, widthFlood: true)
                        NG_Button(title: "Restore and loose current data".localized(for: language), style: .NG_ButtonStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                            hideBackButton = true
                            isLoading = true
                            SavingDispatchQueue.async {
                                let childContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                                childContext.parent = PersistenceController.shared.container.viewContext
                                childContext.automaticallyMergesChangesFromParent = false
                                Data_Archival(theFile: fileDirectory!.appendingPathComponent(fileSelectorForHovers), theContext: childContext).restore()
                                do{
                                    try childContext.save()
                                    try viewContext.save()
                                }catch{}
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
                .NG_Card(.NG_CardStyle_Regular, theme: theme)
                .padding(.horizontal)
            }
            
            if(showResetConfirmaton){
                VStack{
                    Text("This opearation will erase all current data and reload factory defaults. What means that the current data will be lost with no undo option. Do you want to make a backup of existing data before the flush?".localized(for: language))
                        .NG_textStyling(.NG_TextStyle_Text_Regular, .NG_TextColor_Red, theme: theme)
                        .padding(10)
                    VStack{
                        NG_Button(title: "Archive before reset".localized(for: language), style: .NG_ButtonStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
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
                            showResetConfirmaton = false
                        }, widthFlood: true)
                        NG_Button(title: "Reset and loose current data".localized(for: language), style: .NG_ButtonStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                            hideBackButton = true
                            isFlushing = true
                            SavingDispatchQueue.async {
                                let childContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                                childContext.parent = PersistenceController.shared.container.viewContext
                                childContext.automaticallyMergesChangesFromParent = false
                                Data_Archival(theFile: fileDirectory!.appendingPathComponent(fileSelectorForHovers), theContext: childContext).flush()
                                //Settings.setLocale(language, in: childContext)
                                do{
                                    try childContext.save()
                                    try viewContext.save()
                                }catch{}
                                //Presets.reloadByLanguage(LocaleView.LocaleItem.filePrefix(for: language), in: viewContext)
                                let fileDirectory: URL? = Bundle.main.resourceURL
                                if let presetFiles = Bundle.main.urls(forResourcesWithExtension: "alpres", subdirectory: nil) {
                                    for fileURL in presetFiles.sorted{$0.lastPathComponent < $1.lastPathComponent} {
                                        childContext.performAndWait{
                                            Data_Archival(theFile: fileDirectory!.appendingPathComponent(fileURL.lastPathComponent), theContext: childContext).preset(progress: presetsProgress, index: 1, total: 1)
                                        }
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
                                    }
                                }
                                DispatchQueue.main.sync {
                                    reloadListOfFiles()
                                    isFlushing = false
                                    hideBackButton = false
                                }
                            }
                            showResetConfirmaton = false
                        }, widthFlood: true)
                        NG_Button(title: "Cancel".localized(for: language), style: .NG_ButtonStyle_Regular, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                            showResetConfirmaton = false
                        }, widthFlood: true)
                    }
                }
                .NG_Card(.NG_CardStyle_Regular, theme: theme)
                .padding(.horizontal)
            }
            
            if(isSaving){
                VStack{
                    Text("DATA SAVE IS IN PROGRESS...".localized(for: language))
                        .NG_textStyling(.NG_TextStyle_Text_Regular,.NG_TextColor_Regular, theme: theme)
                        .padding()
                }
                .NG_Card(.NG_CardStyle_Regular, theme: theme)
                .padding(.horizontal)
            }
            
            if(isLoading){
                VStack{
                    Text("DATA LOAD IS IN PROGRESS...".localized(for: language))
                        .NG_textStyling(.NG_TextStyle_Text_Regular,.NG_TextColor_Green, theme: theme)
                        .padding()
                }
                .NG_Card(.NG_CardStyle_Green, theme: theme)
                .padding(.horizontal)
            }
            
            if(isFlushing){
                VStack{
                    Text("DATA FLUSH IS IN PROGRESS...".localized(for: language))
                        .NG_textStyling(.NG_TextStyle_Text_Regular,.NG_TextColor_Red, theme: theme)
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
                leading:
                    BackButton(action: {
                        dismiss()
                    })
            )
        }
    }
    private func reloadListOfFiles(){
        do{
            let documentDirectory = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            fileDirectory = documentDirectory
            let directoryContents = try FileManager.default.contentsOfDirectory(
                at: fileDirectory!,
                includingPropertiesForKeys: nil
            ).filter{$0.lastPathComponent.hasSuffix(".gharch")}.sorted{$0.lastPathComponent > $1.lastPathComponent}
            listOfFiles.removeAll()
            for url in directoryContents {
                listOfFiles.append(url.lastPathComponent)
            }
        }catch{}
        reloadInvokation += 1
    }
    private func removalConfirmationSection() -> some View {
        VStack{
            Text("This opearation will cause overwrite of current information with the one stored in archive file. What means that the current information will be lost with no undo option. Do you want to make a backup of existing information before the restoration of the archive?".localized(for: language))
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding(10)
            HStack{
                Spacer()
                Text("ARCHIVE BEFORE RESTORE".localized(for: language))
                    .font(.title)
                    .foregroundStyle(.green)
                    .padding(10)
                    .background(Color(red: 0.00, green: 0.00, blue: 0.00, opacity: 0.50))
                    .border(.green)
                    .onTapGesture {
                        hideBackButton = true
                        isSaving = true
                        SavingDispatchQueue.async {
                            let childContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                            childContext.parent = PersistenceController.shared.container.viewContext
                            childContext.automaticallyMergesChangesFromParent = false
                            DispatchQueue.main.sync {
                                reloadListOfFiles()
                                isLoading = false
                                hideBackButton = false
                            }
                        }
                        showRestorationConfirmation = false
                    }
                Spacer()
                Text("RESTORE AND LOOSE CURRENT INFORMATION".localized(for: language))
                    .font(.title)
                    .foregroundStyle(.blue)
                    .padding(10)
                    .background(Color(red: 0.00, green: 0.00, blue: 0.00, opacity: 0.50))
                    .border(.blue)
                    .onTapGesture {
                        hideBackButton = true
                        isLoading = true
                        SavingDispatchQueue.async {
                            let childContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                            childContext.parent = PersistenceController.shared.container.viewContext
                            childContext.automaticallyMergesChangesFromParent = false
                            Data_Archival(theFile: fileDirectory!.appendingPathComponent(fileSelectorForHovers), theContext: childContext).restore()
                            do{
                                try childContext.save()
                                try viewContext.save()
                            }catch{}
                            DispatchQueue.main.sync {
                                reloadListOfFiles()
                                isLoading = false
                                hideBackButton = false
                            }
                        }
                        showRestorationConfirmation = false
                    }
                Spacer()
                Text("CANCEL RESTORATION".localized(for: language))
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(Color(red: 0.00, green: 0.00, blue: 0.00, opacity: 0.50))
                    .border(.white)
                    .onTapGesture {
                        showRestorationConfirmation = false
                    }
                Spacer()
            }
        }
        .padding(20)
        .background(Color(red: 0.0, green: 0.0, blue: 0.5, opacity: 0.5))
        .border(.red)
    }
}
