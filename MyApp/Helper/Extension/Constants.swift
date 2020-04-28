//
//  Constants.swift
//  NhacVn
//
//  Created by Anh Tu on 6/27/17.
//  Copyright © 2017 Anh Tu. All rights reserved.
//

import Foundation
import UIKit
//static let code = "errorCode"
//static let data = "data"
//static let message = "errorMsg"
//static let total = "total"

let BVdomain: String = "http://a9dd47be.ngrok.io/api/v1/"  // Domain Product
struct Constants {
    enum TypeAlbum {
        case None
        case Recomment
        case PlayAll
    }
    
//    struct Colors {
//        static let appColor = UIColor(rgb: 0x00A04B)
//    }
    
//    static func navigationBarTitleTextSize() -> CGFloat {
//        return DeviceHelper.isIdiomPad() ? 16.0 : 17.0;
//    }
    
    struct Padding {
        static let int: Int = 15
        static let float: Float = 15
        static let double: Double = 15
        static let cgFLoat: CGFloat = 15
    }
    
    struct KeyboardAnimation {
        static let duration = 0.3
        static let minimumScrollFraction: CGFloat = 0.2
        static let maximumScrollFraction: CGFloat = 0.8
    }
    
    static let keyboardHeight: CGFloat = 216.0
    
    struct AccountForder {
        static let Image = "%@-img"
        static let Mp3 = "%@-music"
        static let Mp4 = "%@-video"
        static let thumbFolder = "Thumbnail"
    }
    
    struct FileName {
        static let ThumbImage = "%@.jpg"
        static let Mp3 = "%@.mp3"
        static let Flac = "%@.flac"
        static let Mp4 = "%@.mp4"
        static let thumbThumb = "%@-thumb.jpg"
    }
    
    struct UserdefaultKey {
        static let Session3G = "NhacVNSessionWithoutVegaID"
        static let SessionVegaID = "VegaIDSession"
        static let SongDetailTutorial = "Song_Detail_Tutorial"
        static let NameUser = "Name_User_Login"
        static let UserVegaID = "User_Vega_ID"
        static let AccessToken = "User_Vega_ID"
        static let TypeSignin = "Type_Sign_in"
    }
    
    static let SETTINGS_ACCOUNT = "SETTINGS_ACCOUNT"
    static let Song_Detail_Background = "Song_Detail_Background"
    static let key_api = "q.J}sKj5!V?ZN3.H"
    static let cacheAvatar = "imageAvatarCache"
    static let SESSTION_ID_APP = "SESSTION_ID_APP"
    static let USER_ANYMOUS_ID = "USER_ANYMOUS_ID"
    
}

struct Analytic {
    enum Category: String {
        case Home = "HOME"
        case ContentMore = "Content more"
        case PlayerDetail = "Player Detail"
        case MiniPlayer = "Mini player"
        case Search = "Search"
        case Persional = "Cá nhân"
        case Account = "Account"
        case PlayBlock40 = "ClickBlock40"
        case Detect3G = "IOS_3G_Login"
        case MyMusic = "My Music"
        case VipSongButton = "Vip Song Button"
        case VipVideoButton = "Vip Video Button"
        case VipSongPopup = "Vip Song Popup"
        case PlayADSong = "Play by Ad Song"
        case PlayByVipSong = "Play by Vip Song"
    }
}

struct NVErrorCode   {
    static let notValidate = 400
    static let notValidate1 = 1002
    static let needBuyPackage = 1059
    static let needBuyPackage1051 = 1051
    static let tokenError_2001 = 2001
}

struct homeSlideType {
    static let album = "album"
    static let video = "video"
    static let song = "song"
    static let custom = "custom"
}

struct NavigationItemType {
    
    enum Left : Int {
        case none = 0
        case back = 1
        case menu = 2
    }
    
    enum Right : Int {
        case none = 0
        case close = 1
        case share = 2
        case vip = 3
        case search = 4
        case vipAndSearch = 7
    }
}

struct NVparamType {
    static let Id = "id"
    static let Ids = "ids"
    static let Data = "data"
    static let total = "total"
    static let type = "_type"
    static let typeNone = "type"
    static let title = "title"
    static let Desctiption = "description"
    static let limit = "limit"
    static let offset = "offset"
    static let suggestion = "suggestion"
}

enum NVObjectType: String {
    case None = "none"
    case Song = "song"
    case Video = "video"
    case Album = "album"
    case Playlist = "playlist"
    case Artist = "artist"
    case PlaylistRecommend = "playlist_recommend"
    case UserPlaylist = "user_playlist"
}

enum MediaType: Int {
    case None = 0
    case Online = 1
    case Offline = 2
    case Device = 3
//    case Chart = 4
}
enum SocialType: String {
    case Facebook = "1"
    case Google = "2"
}

enum SongHomeType: Int {
    case None = 0
    case Chart = 1
    case New = 2
    case search = 3
    case Notifi = 4
}

enum AlbumHomeType: Int {
    case None = 0
    case HomeHot = 1
    case HomeRecommend = 2
    case HomeToday = 3
    case HomeMixAlbum = 4
    case HomeHistory = 5
}

enum AlbumOfflineType: Int {
    case None = 0
    case MyPlaylistCreate = 1
    case MyPlaylistDownload = 2
    case AlbumDownload = 3
    case AlbumDevice = 4
}

enum MediaNature: Int {
    case None = 0
    case New = 1
    case Hot = 2
    case Recomment = 3
    case Chart = 4
}

enum PlayerMode: Int {
    case None = 0
    case One = 1
    case Multi = 2
}

struct VGMediaType {
    enum MusicRepeatMode: Int {
        case None = 2
        case All = 0
        case One = 1
        case Shuffle = 3
    }
    
    enum MusicShuffleMode: Int {
        case None = 0
        case All = 1
    }
    
    enum MusicState: Int {
        case None = 0
        case Pause = 1
        case Play = 2
        case Stop = 3
        case Complete = 4
        case Next = 5
        case Previous = 6
        case Buffer = 7
        case Error = 8
    }
    
    enum MusicPlayType {
        case Normal
        case Next
        case Previous
        case Finish
    }
    
    enum MusicSaveKey: String {
        case RepeatMode = "VGMEDIACENTER_REPEATE_MODE"
        case ShuffleMode = "VGMEDIACENTER_SHUFFLE_MODE"
    }
    
}

//struct NVColor {
//    static let artistColor = UIColor(rgb: 0x21B685)
//    static let subTitleColor = UIColor(rgb: 0xB7BCB9)
//    static var titleColor: UIColor = {
//        if Preferences.isDarkTheme{
//            return UIColor.white
//        } else{
//            return UIColor(rgb: 0x1F2F25)
//        }
//    }()
//    static var headerTitleColor: UIColor = {
//        if Preferences.isDarkTheme{
//            return UIColor.white
//        } else{
//            return UIColor(rgb: 0x192536)
//        }
//    }()
//    static var backgroundColor: UIColor = {
//        if Preferences.isDarkTheme {
//            return UIColor(rgb: 0x192536)
//        } else{
//            return UIColor(rgb: 0x000000)
//        }
//    }()
//    
//    static var activeColor: UIColor = UIColor(rgb: 0x21B685) //UIColor(rgb: 0x14EB69)
//    static var active3GColor : UIColor = UIColor(rgb: 0x4DC59D)
//    static var navigationColor: UIColor = UIColor(rgb: 0x21324A)
//    static var activeColorUInt: UInt = 0x21B685//0x14EB69
//    static var ButtonBgColor: UIColor = UIColor(rgb: 0x21324A)
//    static var otherBackgroundColor: UIColor = UIColor(rgb: 0x1E1E29)
//}

enum BVNotificationType: String {
    case None = "None"
    case CategoryReload = "CategoryReload"
    case UpdateProfile = "UpdateProfile"
}

enum NVMediaDetailMode: Int {
    case None = 0
    case showFullDetail = 1
    case showMiniPlayer = 2
    case showLostConnection = 3
    case changeView = 4
}

enum NVforder: String {
    case SongDetailPick = "SongDetailPick"
}

enum NVEditVCState {
    case Normal
    case Edit
}

enum YoutubeEmbedStatus: Int {
    case Nhac = 0
    case Youtube = 1
}
enum YoutubeBlockStatus: Int {
    case Block = 0
    case Allow = 1
}

//MARK: Notification
struct NVNotificationKey{
    struct VGMediaKey {
        static let StateChange = Notification.Name(rawValue: "NOTI_MUSIC_STATE_CHANGE")
    }
    
    struct User {
        static let Login = Notification.Name("LOGIN")
        static let Logout = Notification.Name("LOGOUT")
    }
    
    struct Other {
        static let BackToLoginPress = Notification.Name("Back_To_Login_Press")
    }
    
    static let ChangeTheme = Notification.Name("ChangeThemeNV")
    
    
}











