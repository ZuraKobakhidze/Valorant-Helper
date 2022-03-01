import Foundation

struct VHNavBarVM {
    let navBarStyle: NavBarStyle
    let leftAction: (() -> Void)?
}

enum NavBarStyle {
    case withLogo
    case withAgentImage(agentImage: String)
}
