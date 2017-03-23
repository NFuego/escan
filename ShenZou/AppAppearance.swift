
import Foundation

public extension UIColor {

//    http://www.color-hex.com/color-palettes/

    public class var options:UIColor  {
//        38	48	83
       return UIColor(red: 38/255, green: 48/255, blue: 83/255, alpha: 1)
    }

    public class var uiviewHeader:UIColor {
//        54	203	170	
        return UIColor(red: 54/255, green: 203/255, blue:170/255, alpha: 1)
    }

    // palete theme dance studio
    public class var dance:UIColor {
        return UIColor(hex: "#ffa1a7")
    }

    public class var youngGirl:UIColor {
        return UIColor(hex:"#d888ff")
    }

    public class var soakedToRed:UIColor {
        return UIColor(hex:"#60d2f9")
    }

    public class var sunset:UIColor {
        return UIColor(hex:"#ffc884")
    }

    public class var ocean:UIColor {
        return UIColor(hex:"#0084fd")
    }

    public class var freshPink:UIColor {
        return UIColor(hex:"#ff3377")
    }

}
