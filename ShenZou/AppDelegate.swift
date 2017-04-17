
import UIKit
import SlideMenuControllerSwift
import RxSwift
import Moya
import SwiftyJSON
import XCGLogger
import GoogleMobileAds
import FirebaseAnalytics
import MessageUI


let appId =  "ca-app-pub-5407585558041236~7852705102"
let adGlobalBaseId = "ca-app-pub-5407585558041236/9329438302"
let testId = "c42f210c300755999d430f0a2b2ca59b"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let dpg = DisposeBag()
    let log = XCGLogger.default
    
    // Var

// icon
//    https://icons8.com/web-app/for/all/arrow

//    應用程式編號：ca-app-pub-5407585558041236~7852705102
//    廣告單元編號：ca-app-pub-5407585558041236/
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
/*
         - crash analytic
         - global ui style config
         - version checking 
         - login status
         - persistence checking
         - di setup
         - ble restore 
         
         */
        SuccOrigamiConfig.appMode = .development
        SuccOrigamiConfig.useAd = false
//        SuccOrigamiConfig.appMode = .production
//        configLog()wiZXhwIjoxNDg5OTQ1NTkyLCJuYmYiOjE0ODIwNTYzNzIsImp0a
        configUIAppearance()

        let slideVC = SlideVC()
//        let slideMenuController = SlideMenuController(mainViewController: leftVC.inOneVC, leftMenuViewController: leftVC)
//        let slideMenuController = SlideMenuController(mainViewController: welcomeVC, leftMenuViewController: leftVC)
        let slideMenuController = SlideMenuController(mainViewController: SlideVC.qrcodeScanVC, leftMenuViewController: slideVC)
        
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()

        // Configure Admob
        FIRApp.configure()



//        print(hexString)
        // first time
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

// MARK:- Firebase Config
extension AppDelegate {
    
}

// MARK:- Logger
extension AppDelegate {
    func configLog(){
        log.setup(level: .debug, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: "szDevLog", fileLevel: .debug)
    }
}

// MARK:- UI Config
extension AppDelegate {
    func configUIAppearance(){
//        let lbFt = UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)
        let lbFt = UIFont(name: "HelveticaNeue-Thin", size: 27)
//        [[UILabel appearance]setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:32.0f]];
        UILabel.appearance().defaultFont = lbFt
    }
}


extension UILabel{
    dynamic var defaultFont: UIFont? {
        get { return self.font }
        set {
            let sizeOfOldFont = self.font.pointSize
            let fontNameOfNewFont = newValue?.fontName
            self.font = UIFont(name: fontNameOfNewFont!, size: sizeOfOldFont)
        }
    }
}


