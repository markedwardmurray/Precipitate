//
//  UIColor+Colors.swift
//  Precipitate
//
//  Created by Mark Murray on 12/15/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit
import SwiftHEXColors

extension UIColor {
    class func notMyChristian() -> UIColor {
        return UIColor(white: 0.9, alpha: 1.0)
    }
    
    class func temperature() -> UIColor {
        return UIColor.blueColor()
    }
    
    class func apparentTemp() -> UIColor {
        return UIColor.purpleColor()
    }
    
    /**
     468EE5
     */
    class func havelockBlue() -> UIColor {
        return UIColor(red:70/255.0, green:142/255.0, blue:229/255.0, alpha:255/255.0)
    }
    
    class func beauBlue() -> UIColor {
        return UIColor(red: 0.75, green: 0.85, blue: 0.94, alpha: 1.0)
    }
    
    class func glitter() -> UIColor {
        return UIColor(red:225/255.0, green:238/255.0, blue:251/255.0, alpha:255/255.0)
    }
    
    class func solitude() -> UIColor {
        return UIColor(red:237/255.0, green:245/255.0, blue:253/255.0, alpha:255/255.0)
    }
    
    class func aliceBlue() -> UIColor {
        return UIColor(red:241/255.0, green:248/255.0, blue:253/255.0, alpha:255/255.0)
    }
    
    /**
     HEX: A5CEFF
     RGB: 165–206–255
     */
    class func p0BabyBlueEyes() -> UIColor {
        return UIColor(hexString: "A5CEFF")!
    }
    
    /**
     HEX: 73B1FB
     RGB: 115–177–251
     */
    class func p1MayaBlue() -> UIColor {
        return UIColor(hexString: "73B1FB")!
    }
    
    /**
     HEX: 468EE5
     RGB: 70–142–229
     */
    class func p2HavelockBlue() -> UIColor {
        return UIColor(hexString: "468EE5")!
    }
    
    /**
     HEX: 2F5888
     RGB: 47–88–136
     */
    class func p3Endeavor() -> UIColor {
        return UIColor(hexString: "2F5888")!
    }
    
    /**
     HEX: 233347
     RGB: 35–51–71
     */
    class func p4BlueWhale() -> UIColor {
        return UIColor(hexString: "233347")!
    }
    
    /**
     HEX: A8BBFF
     RGB: 168–187–255
     */
    class func s0Perano() -> UIColor {
        return UIColor(hexString: "A8BBFF")!
    }
    
    /**
     HEX: 7995FB
     RGB: 121–149–251
     */
    class func s1FadedBlue() -> UIColor {
        return UIColor(hexString: "7995FB")!
    }

    /**
     HEX: 4D6EE7
     RGB: 77–110–231
     */
    class func s2RoyalBlue() -> UIColor {
        return UIColor(hexString: "4D6EE7")!
    }

    /**
     HEX: 34478D
     RGB: 77–110–231
     */
    class func s3Chambray() -> UIColor {
        return UIColor(hexString: "34478D")!
    }

    /**
     HEX: 252D4A
     RGB: 37–45–74
     */
    class func s4LuckyPoint() -> UIColor {
        return UIColor(hexString: "252D4A")!
    }

    /**
     HEX: A0E7FF
     RGB: 160–231–255
     */
    class func t0Anakiwa() -> UIColor {
        return UIColor(hexString: "A0E7FF")!
    }
    
    /**
     HEX: 6CD7FB
     RGB: 108–215–251
     */
    class func t1TurquoiseBlue() -> UIColor {
        return UIColor(hexString: "6CD7FB")!
    }

    /**
     HEX: 3EBAE3
     RGB: 62–186–227
     */
    class func t2SummerSky() -> UIColor {
        return UIColor(hexString: "3EBAE3")!
    }

    /**
     HEX: 296C82
     RGB: 41–108–130
     */
    class func t3AllPorts() -> UIColor {
        return UIColor(hexString: "296C82")!
    }

    /**
     HEX: 1F3B44
     RGB: 31–59–68
     */
    class func t4LeprechaunMist() -> UIColor {
        return UIColor(hexString: "1F3B44")!
    }
}
