import SwiftUI

struct WizardContainerView: View {
    @ObservedObject var coordinator: WizardCoordinator

    var body: some View {
        VStack {
            coordinator.currentStep
        }
        .interactiveDismissDisabled(true)
        //.padding()
    }
}
