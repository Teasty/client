// MARK: Realm Class

import RealmSwift

class Address: Object {
    @objc dynamic var hashId: String = String()
    @objc dynamic var city: String = String()
    @objc dynamic var street: String = String()
    @objc dynamic var house: String = String()
    @objc dynamic var porch: String = String()
    @objc dynamic var address: String = String()
    @objc dynamic var lng: Double = Double()
    @objc dynamic var lat: Double = Double()
    @objc dynamic var isExist: Bool = Bool()
    @objc dynamic var created: Int = Int()
    @objc dynamic var updated: Int = Int()
    override class func primaryKey() -> String? {
       return "hashId"
   }
}

class Car: Object {
    @objc dynamic var model: String = String()
    @objc dynamic var updated: Int = Int()
    @objc dynamic var hashId: String = String()
    @objc dynamic var created: Int = Int()
    @objc dynamic var isExist: Bool = Bool()
    @objc dynamic var color: String = String()
    @objc dynamic var carNum: String = String()
    override class func primaryKey() -> String? {
       return "hashId"
   }
}

class Config: Object {
    @objc dynamic var preOrderA2Time: Int = Int()
    @objc dynamic var narestOrdersForDriverRadius: Int = Int()
    @objc dynamic var ordersMapVisibilityRadius: Int = Int()
    @objc dynamic var A2OrderTime: Int = Int()
    @objc dynamic var nearestDriversRadius: Int = Int()
    @objc dynamic var hashId: String = String()
    @objc dynamic var orderRejectTime: Int = Int()
    @objc dynamic var A1OrderTime: Int = Int()
    @objc dynamic var isExist: Bool = Bool()
    @objc dynamic var isDiscountAvailable: Bool = Bool()
    @objc dynamic var orderRejectsNum: Int = Int()
    @objc dynamic var acceptOrderTime: Int = Int()
    @objc dynamic var driverBlockTime: Int = Int()
    @objc dynamic var updated: Int = Int()
    @objc dynamic var preOrderA1Time: Int = Int()
    @objc dynamic var created: Int = Int()
    @objc dynamic var ordersNumInProfile: Int = Int()
    @objc dynamic var kolhozOrderTime: Int = Int()
    @objc dynamic var orderEmitToDriverRadius: Int = Int()
    @objc dynamic var discount: Int = Int()
    @objc dynamic var ridesToGetDiscount: Int = Int()
    @objc dynamic var isBlockAvailable: Bool = Bool()
    @objc dynamic var name: String = String()
    override class func primaryKey() -> String? {
       return "hashId"
   }
}

class Document: Object {
    @objc dynamic var title: String = String()
    @objc dynamic var __type: String = String()
    @objc dynamic var text: String = String()
    @objc dynamic var isExist: Bool = Bool()
    @objc dynamic var hashId: String = String()
    @objc dynamic var updated: Int = Int()
    @objc dynamic var created: Int = Int()
    override class func primaryKey() -> String? {
       return "hashId"
   }
}

class DriverDocument: Object {
    @objc dynamic var title: String = String()
    @objc dynamic var __type: String = String()
    @objc dynamic var text: String = String()
    @objc dynamic var isExist: Bool = Bool()
    @objc dynamic var hashId: String = String()
    @objc dynamic var updated: Int = Int()
    @objc dynamic var created: Int = Int()
    override class func primaryKey() -> String? {
       return "hashId"
   }
}

class Image: Object {
    @objc dynamic var isExist: Bool = Bool()
    @objc dynamic var original: String = String()
    @objc dynamic var created: Int = Int()
    @objc dynamic var preview: String = String()
    @objc dynamic var hashId: String = String()
    @objc dynamic var updated: Int = Int()
    override class func primaryKey() -> String? {
       return "hashId"
   }
}

class Msg: Object {
    @objc dynamic var orderHashId: String = String()
    @objc dynamic var driverHashId: String = String()
    @objc dynamic var __type: String = String()
    @objc dynamic var text: String = String()
    @objc dynamic var mssqlId: String = String()
    @objc dynamic var hashId: String = String()
    @objc dynamic var updated: Int = Int()
    @objc dynamic var isExist: Bool = Bool()
    @objc dynamic var timestamp: Int = Int()
    @objc dynamic var created: Int = Int()
    override class func primaryKey() -> String? {
       return "hashId"
   }
}

class Payment: Object {
    @objc dynamic var lastCardDigits: String = String()
    @objc dynamic var created: Int = Int()
    @objc dynamic var isExist: Bool = Bool()
    @objc dynamic var hashId: String = String()
    @objc dynamic var rebillAnchor: String = String()
    @objc dynamic var updated: Int = Int()
    override class func primaryKey() -> String? {
       return "hashId"
   }
}

class Stop: Object {
    @objc dynamic var arrivalTime: Int = Int()
    @objc dynamic var created: Int = Int()
    @objc dynamic var isExist: Bool = Bool()
    @objc dynamic var name: String = String()
    @objc dynamic var hashId: String = String()
    @objc dynamic var updated: Int = Int()
    override class func primaryKey() -> String? {
       return "hashId"
   }
}

class Tariff: Object {
    @objc dynamic var info: String = String()
    @objc dynamic var hashId: String = String()
    @objc dynamic var serialNumber: Int = Int()
    @objc dynamic var fixedModifier: Int = Int()
    @objc dynamic var isExist: Bool = Bool()
    @objc dynamic var created: Int = Int()
    @objc dynamic var name: String = String()
    @objc dynamic var image: Image?
    @objc dynamic var updated: Int = Int()
    @objc dynamic var coefficient: Double = Double()
    override class func primaryKey() -> String? {
       return "hashId"
   }
}

class User: Object {
    @objc dynamic var lastName: String = String()
    @objc dynamic var tokenFCM: String = String()
    @objc dynamic var isVipAvailable: Bool = Bool()
    @objc dynamic var firstName: String = String()
    @objc dynamic var isAdmin: Bool = Bool()
    @objc dynamic var car: Car?
    @objc dynamic var created: Int = Int()
    @objc dynamic var ridesCount: Int = Int()
    @objc dynamic var updated: Int = Int()
    @objc dynamic var isEconomAvailable: Bool = Bool()
    @objc dynamic var callsign: String = String()
    @objc dynamic var isBlocked: Bool = Bool()
    @objc dynamic var chainOrder: Bool = Bool()
    @objc dynamic var autoOrder: Bool = Bool()
    @objc dynamic var hashId: String = String()
    @objc dynamic var balance: Int = Int()
    @objc dynamic var tariffSerialNumber: Int = Int()
    @objc dynamic var mssqlId: String = String()
    @objc dynamic var email: String = String()
    @objc dynamic var deviceId: String = String()
    let cards = List<Payment>()
    @objc dynamic var category: String = String()
    @objc dynamic var phone: String = String()
    
    @objc dynamic var isExist: Bool = Bool()
    let stringArr = List<String>()
    @objc dynamic var isStandardAvailable: Bool = Bool()
    @objc dynamic var lastReject: Int = Int()
    @objc dynamic var isDriver: Bool = Bool()
    @objc dynamic var activeCard: Payment?
    override class func primaryKey() -> String? {
       return "hashId"
   }
}

class WishList: Object {
    @objc dynamic var singleValue: WishListValue?
    @objc dynamic var hashId: String = String()
    let multipleValue = List<WishListValue>()
    @objc dynamic var isExist: Bool = Bool()
    @objc dynamic var created: Int = Int()
    @objc dynamic var image: Image?
    @objc dynamic var name: String = String()
    @objc dynamic var updated: Int = Int()
    @objc dynamic var __type: String = String()
    override class func primaryKey() -> String? {
       return "hashId"
   }
}

class WishListValue: Object {
    @objc dynamic var updated: Int = Int()
    @objc dynamic var price: Double = Double()
    @objc dynamic var hashId: String = String()
    @objc dynamic var name: String = String()
    @objc dynamic var created: Int = Int()
    @objc dynamic var isExist: Bool = Bool()
    override class func primaryKey() -> String? {
       return "hashId"
   }
}

class Order: Object {
    @objc dynamic var departure: Address?
    @objc dynamic var change: Int = Int()
    @objc dynamic var driver: User?
    let wishListValues = List<WishListValue>()
    @objc dynamic var timeRideStart: Int = Int()
    @objc dynamic var upCost: Int = Int()
    @objc dynamic var isExist: Bool = Bool()
    @objc dynamic var stopTo: Stop?
    @objc dynamic var __status: String = String()
    @objc dynamic var timeDriverExpected: Int = Int()
    @objc dynamic var tariff: Tariff?
    @objc dynamic var mssqlId: String = String()
    @objc dynamic var intermediatePoint1: Address?
    @objc dynamic var clientPhone: String = String()
    let wishList = List<WishList>()
    @objc dynamic var timeRequired: Int = Int()
    let messages = List<Msg>()
    @objc dynamic var updated: Int = Int()
    @objc dynamic var price: Double = Double()
    @objc dynamic var client: User?
    @objc dynamic var created: Int = Int()
    @objc dynamic var paymentType: String = String()
    @objc dynamic var isDiscountRide: Bool = Bool()
    @objc dynamic var hashId: String = String()
    @objc dynamic var stopFrom: Stop?
    @objc dynamic var isIOSFinish: Bool = Bool()
    @objc dynamic var arrival: Address?
    @objc dynamic var intermediatePoint2: Address?
    @objc dynamic var timeDriverArrived: Int = Int()
    @objc dynamic var comment: String = String()
    @objc dynamic var timeDriverAccepted: Int = Int()
    @objc dynamic var timeRideEnd: Int = Int()
    @objc dynamic var distance: Double = Double()
    override class func primaryKey() -> String? {
        return "hashId"
    }
}
