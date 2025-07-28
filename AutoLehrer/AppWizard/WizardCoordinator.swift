import SwiftUI

class WizardCoordinator: ObservableObject {
    enum Flow {
    }

    @Published var isPresented: Bool = false
    @Published var currentStepIndex: Int = 0
    private(set) var steps: [AnyView] = []
    var onFinish: (() -> Void)?

    func start(for flow: Flow, onFinish: (() -> Void)? = nil) {
        
        self.onFinish = onFinish
        switch flow {
        }
        currentStepIndex = 0
        isPresented = true
    }

    func next() {
        if currentStepIndex + 1 < steps.count {
            currentStepIndex += 1
        } else {
            onFinish?()
            currentStepIndex = 0
        }
    }
    
    func jumpTo(sequenceStep: Int){
        if sequenceStep < steps.count {
            currentStepIndex = sequenceStep
        } else {
            onFinish?()
            currentStepIndex = 0
        }
    }
    
    func complete() {
        onFinish?()
        currentStepIndex = 0
    }

    func back() {
        if currentStepIndex > 0 {
            currentStepIndex -= 1
        }
    }

    var currentStep: AnyView {
        guard steps.indices.contains(currentStepIndex) else {
            return AnyView(EmptyView())
        }
        return steps[currentStepIndex]
    }
}
