import UIKit

public struct UserResult: Codable {
    let profileImage: ProfileImage?
}

public struct ProfileImage: Codable {
    let small: String?
    let medium: String?
    let large: String?
}
