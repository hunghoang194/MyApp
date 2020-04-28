//
//  BaseService.swift
//  BinVid
//
//  Created by Admin on 3/3/20.
//  Copyright © 2020 BinVidTeam. All rights reserved.
//

import UIKit
import Alamofire
var profile = MyAUserProfile()
enum BaseServiceURLPath :String{
    case Login = "user/login"
    case LikeUser = "user/like"
    case LogVideo = "video/log"
    case CategoryList = "category"
    case CategoryListForUser = "category-by-user"
    case UpdateProfile = "user"
    case VideoList = "video"
}
enum TypeObjectLike :String{
    case OBJECTCATEGORY = "1"
    case OBJECTVIDEO = "2"
}
enum TypeLikeAction :String{
    case Like = "1"
    case Unlike = "2"
}
public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
class MyABaseService: NSObject {
    static let sharedInstance: MyABaseService = {
        let instance = MyABaseService()
        return instance
    }()
    //    public typealias HTTPHeaders = [String: String]
    
    static func requestServiceWithHeader(header:HTTPHeaders = HTTPHeaders(),isHaveHeader:Bool = true,pathUrl:BaseServiceURLPath,parram:[String:String]?, Completion: @escaping ((_ code: String?,_ data:Any?,_ message:String) -> Void )){
        let url = URL(string: BVdomain.appendingFormat("%@",pathUrl.rawValue))
        var urlRequest = URLRequest(url: url!)
        var method = Alamofire.HTTPMethod.post
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        method = .post
        
        var headers = HTTPHeaders ()
        if isHaveHeader {
            headers = header
            headers["Accept"] = "application/json"
        } else {
            headers = HTTPHeaders()
        }
        //        headers["X-Mashape-Key"] = MY_API_KEY
        
        AF.request(url!, method:method, parameters: parram, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                print(response.request as Any)  // original URL request
                print(response.response as Any) // URL response
                print(response.result as Any) // result of response serialization
                switch response.result {
                case .success(let value):
                    let jsonData = value as! NSDictionary
                    let message = jsonData["message"] as? String
                    Completion("0",jsonData,message ?? "Có lỗi xảy ra")
                    print("****** JSON \(jsonData)")
                case .failure(let error):
                    Completion("1",nil,String(describing: error))
                }
        }
    }
    static func loginSocialWith(model:MyAUserProfile, Completion: @escaping ((_ code: String?,_ data:Any?,_ message:String) -> Void )){
        var parram = [String:String]()
        parram["type"] = SocialType.Facebook.rawValue
        parram["email"] = model.email ?? ""
        parram["full_name"] = model.name ?? ""
        parram["phone"] = model.phone ?? ""
        parram["password"] = model.password ?? ""
        parram["ime"] = UUID().uuidString
        //        parram["token_firebase"] = Messaging.messaging().fcmToken
        parram["token_firebase"] = ""
        parram["avatar"] = model.imageUrl ?? ""
        parram["birthday"] = ""
        parram["url"] = ""
        self.requestServiceWithHeader(pathUrl: .Login, parram: parram) { (code, Data, message) in
            Completion(code,Data,message)
        }
    }
    static func getListCategory(key:String = "",Completion: @escaping ((_ code: String?,_ data:Any?,_ message:String) -> Void )){
         var parram = [String:String]()
            parram["key"] = key
        if let user = Preferences.sharedInstance.userModel {
            var headers = HTTPHeaders ()
            headers["Authorization"] = String(format: "Bearer %@", user.accessToken!)
            self.requestServiceWithHeader( header:headers,isHaveHeader:true,pathUrl: .CategoryList, parram: parram) { (code, Data, message) in
                Completion(code,Data,message)
            }
        }else{
            self.requestServiceWithHeader(pathUrl: .CategoryList, parram: parram) { (code, Data, message) in
                Completion(code,Data,message)
            }
            
        }
    }
    static func getListVideoForUser(parram:[String:String],Completion: @escaping ((_ code: String?,_ data:Any?,_ message:String) -> Void )){
        if let user = Preferences.sharedInstance.userModel {
            var headers = HTTPHeaders ()
            headers["Authorization"] = String(format: "Bearer %@", user.accessToken!)
            self.requestServiceWithHeader( header:headers,isHaveHeader:true,pathUrl: .VideoList, parram: parram) { (code, Data, message) in
                Completion(code,Data,message)
            }
        }else{
            self.requestServiceWithHeader(pathUrl: .VideoList, parram: parram) { (code, Data, message) in
                Completion(code,Data,message)
            }
            
        }
    }
    static func likeObjectWithType(idObject:Int,type:TypeLikeAction = .Like,objectType:TypeObjectLike = .OBJECTVIDEO,Completion: @escaping ((_ code: String?,_ data:Any?,_ message:String) -> Void )){
        //type "1:like 2:unlike"
        //object_type OBJECT_CATEGORY = 1,OBJECT_VIDEO    = 2;
        
        if let user = Preferences.sharedInstance.userModel {
            var parram = [String:String]()
            parram["object_type"] = objectType.rawValue
            parram["object_id"] = "\(idObject)"
            parram["type"] = type.rawValue
            var headers = HTTPHeaders ()
            headers["Authorization"] = String(format: "Bearer %@", user.accessToken!)
            self.requestServiceWithHeader( header:headers,isHaveHeader:true,pathUrl: .LikeUser, parram: parram) { (code, Data, message) in
                Completion(code,Data,message)
            }
        }
        
    }
    
}
