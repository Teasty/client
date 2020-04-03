// MARK: Parser

import SwiftyJSON
import RealmSwift
//import SwiftEventBus

class Parser {

    public func parseAnyObject(_ object: String, _ json: JSON) {
        for element in json {
            switch object {
            case "Address": _ = parseAddress(element.1)
            case "Car": _ = parseCar(element.1)
            case "Config": _ = parseConfig(element.1)
            case "Document": _ = parseDocument(element.1)
            case "DriverDocument": _ = parseDriverDocument(element.1)
            case "Image": _ = parseImage(element.1)
            case "Msg": _ = parseMsg(element.1)
            case "Order": _ = parseOrder(element.1)
            case "Payment": _ = parsePayment(element.1)
            case "Stop": _ = parseStop(element.1)
            case "Tariff": _ = parseTariff(element.1)
            case "User": _ = parseUser(element.1)
            case "WishList": _ = parseWishList(element.1)
            case "WishListValue": _ = parseWishListValue(element.1)
            default: break
            }
        }

//            switch object {
//            case "Address": SwiftEventBus.post(utils.realm.address.eventBus)
//            case "Car": SwiftEventBus.post(utils.realm.car.eventBus)
//            case "Config": SwiftEventBus.post(utils.realm.config.eventBus)
//            case "Document": SwiftEventBus.post(utils.realm.document.eventBus)
//            case "DriverDocument": SwiftEventBus.post(utils.realm.driverdocument.eventBus)
//            case "Image": SwiftEventBus.post(utils.realm.image.eventBus)
//            case "Msg": SwiftEventBus.post(utils.realm.msg.eventBus)
//            case "Order": SwiftEventBus.post(utils.realm.order.eventBus)
//            case "Payment": SwiftEventBus.post(utils.realm.payment.eventBus)
//            case "Stop": SwiftEventBus.post(utils.realm.stop.eventBus)
//            case "Tariff": SwiftEventBus.post(utils.realm.tariff.eventBus)
//            case "User": SwiftEventBus.post(utils.realm.user.eventBus)
//            case "WishList": SwiftEventBus.post(utils.realm.wishlist.eventBus)
//            case "WishListValue": SwiftEventBus.post(utils.realm.wishlistvalue.eventBus)
//            default: break
//            }
    }

    // MARK: Parse JSON to Realm

    public func parseAddress(_ json: JSON) -> Address? {
        guard let realm = try? Realm() else {
            log.error("Realm initilize error")
            return nil
        }
        let object = Address()
        try? realm.write {
            object.updated = json["updated"].intValue
            object.porch = json["porch"].stringValue
            object.house = json["house"].stringValue
            object.isExist = json["isExist"].boolValue
            object.lng = json["lng"].doubleValue
            object.created = json["created"].intValue
            object.hashId = json["hashId"].stringValue
            object.lat = json["lat"].doubleValue
            object.street = json["street"].stringValue
            object.city = json["city"].stringValue
           
            realm.add(object, update: true)
        }
        return object
    }

    public func parseCar(_ json: JSON) -> Car? {
        guard let realm = try? Realm() else {
            log.error("Realm initilize error")
            return nil
        }
        let object = Car()
        try? realm.write {
            object.updated = json["updated"].intValue
            object.isExist = json["isExist"].boolValue
            object.color = json["color"].stringValue
            object.model = json["carModel"].stringValue
            object.created = json["created"].intValue
            object.hashId = json["hashId"].stringValue
            object.carNum = json["carNumber"].stringValue
            realm.add(object, update: true)
        }
        return object
    }

    public func parseConfig(_ json: JSON) -> Config? {
        guard let realm = try? Realm() else {
            log.error("Realm initilize error")
            return nil
        }
        let object = Config()
        try? realm.write {
            object.A1OrderTime = json["A1OrderTime"].intValue
            object.ordersMapVisibilityRadius = json["ordersMapVisibilityRadius"].intValue
            object.isDiscountAvailable = json["isDiscountAvailable"].boolValue
            object.isBlockAvailable = json["isBlockAvailable"].boolValue
            object.hashId = json["hashId"].stringValue
            object.ridesToGetDiscount = json["ridesToGetDiscount"].intValue
            object.acceptOrderTime = json["acceptOrderTime"].intValue
            object.orderEmitToDriverRadius = json["orderEmitToDriverRadius"].intValue
            object.name = json["name"].stringValue
            object.preOrderA2Time = json["preOrderA2Time"].intValue
            object.A2OrderTime = json["A2OrderTime"].intValue
            object.discount = json["discount"].intValue
            object.isExist = json["isExist"].boolValue
            object.ordersNumInProfile = json["ordersNumInProfile"].intValue
            object.kolhozOrderTime = json["kolhozOrderTime"].intValue
            object.updated = json["updated"].intValue
            object.orderRejectTime = json["orderRejectTime"].intValue
            object.preOrderA1Time = json["preOrderA1Time"].intValue
            object.nearestDriversRadius = json["nearestDriversRadius"].intValue
            object.driverBlockTime = json["driverBlockTime"].intValue
            object.created = json["created"].intValue
            object.orderRejectsNum = json["orderRejectsNum"].intValue
            object.narestOrdersForDriverRadius = json["narestOrdersForDriverRadius"].intValue
            realm.add(object, update: true)
        }
        return object
    }

    public func parseDocument(_ json: JSON) -> Document? {
        guard let realm = try? Realm() else {
            log.error("Realm initilize error")
            return nil
        }
        let object = Document()
        try? realm.write {
            object.title = json["title"].stringValue
            object.isExist = json["isExist"].boolValue
            object.__type = json["__type"].stringValue
            object.hashId = json["hashId"].stringValue
            object.updated = json["updated"].intValue
            object.text = json["text"].stringValue
            object.created = json["created"].intValue
            realm.add(object, update: true)
        }
        return object
    }

    public func parseDriverDocument(_ json: JSON) -> DriverDocument? {
        guard let realm = try? Realm() else {
            log.error("Realm initilize error")
            return nil
        }
        let object = DriverDocument()
        try? realm.write {
            object.title = json["title"].stringValue
            object.isExist = json["isExist"].boolValue
            object.__type = json["__type"].stringValue
            object.hashId = json["hashId"].stringValue
            object.updated = json["updated"].intValue
            object.text = json["text"].stringValue
            object.created = json["created"].intValue
            realm.add(object, update: true)
        }
        return object
    }

    public func parseImage(_ json: JSON) -> Image? {
        guard let realm = try? Realm() else {
            log.error("Realm initilize error")
            return nil
        }
        let object = Image()
        try? realm.write {
            object.hashId = json["hashId"].stringValue
            object.created = json["created"].intValue
            object.preview = json["preview"].stringValue
            object.updated = json["updated"].intValue
            object.original = json["original"].stringValue
            object.isExist = json["isExist"].boolValue
            realm.add(object, update: true)
        }
        return object
    }

    public func parseMsg(_ json: JSON) -> Msg? {
        guard let realm = try? Realm() else {
            log.error("Realm initilize error")
            return nil
        }
        let object = Msg()
        try? realm.write {
            object.timestamp = json["timestamp"].intValue
            object.isExist = json["isExist"].boolValue
            object.__type = json["__type"].stringValue
            object.hashId = json["hashId"].stringValue
            object.updated = json["updated"].intValue
            object.driverHashId = json["driverHashId"].stringValue
            object.text = json["text"].stringValue
            object.created = json["created"].intValue
            object.orderHashId = json["orderHashId"].stringValue
            object.mssqlId = json["mssqlId"].stringValue
            realm.add(object, update: .modified)
        }
        return object
    }

    public func parseOrder(_ json: JSON) -> Order? {
        guard let realm = try? Realm() else {
            log.error("Realm initilize error")
            return nil
        }
        let object = Order()
        let departure: Address? = parseAddress(json["departure"])
        let driver: User? = parseUser(json["driver"])
        var wishlistvalues: [WishListValue] = []
        for element in json["wishListValues"] {
            if let unwarp = parseWishListValue(element.1) {
                wishlistvalues.append(unwarp)
            }
        }
        let stopto: Stop? = parseStop(json["stopTo"])
        let tariff: Tariff? = parseTariff(json["tariff"])
        let intermediatepoint1: Address? = parseAddress(json["intermediatePoint1"])
        var wishlist: [WishList] = []
        for element in json["wishList"] {
            if let unwarp = parseWishList(element.1) {
                wishlist.append(unwarp)
            }
        }
        var messages: [Msg] = []
        for element in json["messages"] {
            if let unwarp = parseMsg(element.1) {
                messages.append(unwarp)
            }
        }
        let client: User? = parseUser(json["client"])
        let stopfrom: Stop? = parseStop(json["stopFrom"])
        let arrival: Address? = parseAddress(json["arrival"])
        let intermediatepoint2: Address? = parseAddress(json["intermediatePoint2"])
        
        var distance: Double = 10.0
//        if let departure = departure, let arrival = arrival {
//            distance = calculateDistance(lat1: departure.latitude, lon1: departure.longitude, lat2: user.location.lat, lon2: user.location.lng)
//        }

        try? realm.write {
            object.hashId = json["hashId"].stringValue
            object.mssqlId = json["mssqlId"].stringValue
            object.__status = json["__status"].stringValue
            log.verbose(json["__status"])
            object.client = client
            object.driver = driver
            object.distance = distance
            object.departure = departure
            object.intermediatePoint1 = intermediatepoint1
            object.intermediatePoint2 = intermediatepoint2
            object.arrival = arrival
            object.tariff = tariff
            object.wishList.append(objectsIn: wishlist)
            object.wishListValues.append(objectsIn: wishlistvalues)
            object.price = json["price"].doubleValue
            object.change = json["change"].intValue
            object.upCost = json["upCost"].intValue
            object.paymentType = json["paymentType"].stringValue
            object.timeDriverExpected = json["timeDriverExpected"].intValue
            object.timeRideStart = json["timeRideStart"].intValue
            object.timeRequired = json["timeRequired"].intValue
            object.timeDriverArrived = json["timeDriverArrived"].intValue
            object.timeDriverAccepted = json["timeDriverAccepted"].intValue
            object.timeRideEnd = json["timeRideEnd"].intValue
            object.comment = json["comment"].stringValue
            object.clientPhone = json["clientPhone"].stringValue
            object.stopFrom = stopfrom
            object.stopTo = stopto
            object.messages.append(objectsIn: messages)
            object.isDiscountRide = json["isDiscountRide"].boolValue
            object.isExist = json["isExist"].boolValue
            object.isIOSFinish = json["isIOSFinish"].boolValue
            object.updated = json["updated"].intValue
            object.created = json["created"].intValue
            realm.add(object, update: .modified)
        }
        return object
    }

    public func parsePayment(_ json: JSON) -> Payment? {
        guard let realm = try? Realm() else {
            log.error("Realm initilize error")
            return nil
        }
        let object = Payment()
        try? realm.write {
            object.hashId = json["hashId"].stringValue
            object.created = json["created"].intValue
            object.updated = json["updated"].intValue
            object.lastCardDigits = json["lastCardDigits"].stringValue
            object.isExist = json["isExist"].boolValue
            object.rebillAnchor = json["rebillAnchor"].stringValue
            realm.add(object, update: true)
        }
        return object
    }

    public func parseStop(_ json: JSON) -> Stop? {
        guard let realm = try? Realm() else {
            log.error("Realm initilize error")
            return nil
        }
        let object = Stop()
        try? realm.write {
            object.hashId = json["hashId"].stringValue
            object.created = json["created"].intValue
            object.updated = json["updated"].intValue
            object.name = json["name"].stringValue
            object.isExist = json["isExist"].boolValue
            object.arrivalTime = json["arrivalTime"].intValue
            realm.add(object, update: true)
        }
        return object
    }

    public func parseTariff(_ json: JSON) -> Tariff? {
        guard let realm = try? Realm() else {
            log.error("Realm initilize error")
            return nil
        }
        let object = Tariff()
        let image: Image? = parseImage(json["image"])
        try? realm.write {
            object.info = json["info"].stringValue
            object.isExist = json["isExist"].boolValue
            object.hashId = json["hashId"].stringValue
            object.updated = json["updated"].intValue
            object.serialNumber = json["serialNumber"].intValue
            object.image = image
            object.fixedModifier = json["fixedModifier"].intValue
            object.created = json["created"].intValue
            object.coefficient = json["coefficient"].doubleValue
            object.name = json["name"].stringValue
            realm.add(object, update: true)
        }
        return object
    }

    public func parseUser(_ json: JSON) -> User? {
        guard let realm = try? Realm() else {
            log.error("Realm initilize error")
            return nil
        }
        let object = User()
        let activecard: Payment? = parsePayment(json["activeCard"])
        var cards: [Payment] = []
        for element in json["cards"] {
            if let unwarp = parsePayment(element.1) {
                cards.append(unwarp)
            }
        }
        let car: Car? = parseCar(json["car"])
        try? realm.write {
            object.tokenFCM = json["tokenFCM"].stringValue
            object.callsign = json["callsign"].stringValue
            object.activeCard = activecard
            object.cards.append(objectsIn: cards)
            object.car = car
            object.email = json["email"].stringValue
            object.isStandardAvailable = json["isStandardAvailable"].boolValue
            object.ridesCount = json["ridesCount"].intValue
            object.isVipAvailable = json["isVipAvailable"].boolValue
            for value in json["stringArr"] { object.stringArr.append(value.1.stringValue) }
            object.isExist = json["isExist"].boolValue
            object.chainOrder = json["chainOrder"].boolValue
            object.autoOrder = json["autoOrder"].boolValue
            object.lastReject = json["lastReject"].intValue
            object.mssqlId = json["mssqlId"].stringValue
            object.isAdmin = json["isAdmin"].boolValue
            object.updated = json["updated"].intValue
            object.created = json["created"].intValue
            object.isDriver = json["isDriver"].boolValue
            object.isBlocked = json["isBlocked"].boolValue
            object.hashId = json["hashId"].stringValue
            object.phone = json["phone"].stringValue
            object.balance = json["balance"].intValue
            object.lastName = json["lastName"].stringValue
            object.deviceId = json["deviceId"].stringValue
            object.isEconomAvailable = json["isEconomAvailable"].boolValue
            object.category = json["category"].stringValue
            object.firstName = json["firstName"].stringValue
            object.tariffSerialNumber = json["tariffSerialNumber"].intValue
            realm.add(object, update: true)
        }
        return object
    }

    public func parseWishList(_ json: JSON) -> WishList? {
        guard let realm = try? Realm() else {
            log.error("Realm initilize error")
            return nil
        }
        let object = WishList()
        var multiplevalue: [WishListValue] = []
        for element in json["multipleValue"] {
            if let unwarp = parseWishListValue(element.1) {
                multiplevalue.append(unwarp)
            }
        }
        let image: Image? = parseImage(json["image"])
        let singlevalue: WishListValue? = parseWishListValue(json["singleValue"])
        try? realm.write {
            object.isExist = json["isExist"].boolValue
            object.__type = json["__type"].stringValue
            object.multipleValue.append(objectsIn: multiplevalue)
            object.hashId = json["hashId"].stringValue
            object.updated = json["updated"].intValue
            object.image = image
            object.created = json["created"].intValue
            object.singleValue = singlevalue
            object.name = json["description"].stringValue
            realm.add(object, update: true)
        }
        return object
    }

    public func parseWishListValue(_ json: JSON) -> WishListValue? {
        guard let realm = try? Realm() else {
            log.error("Realm initilize error")
            return nil
        }
        let object = WishListValue()
        try? realm.write {
            object.hashId = json["hashId"].stringValue
            object.created = json["created"].intValue
            object.updated = json["updated"].intValue
            object.price = json["price"].doubleValue
            object.name = json["description"].stringValue
            object.isExist = json["isExist"].boolValue
            realm.add(object, update: true)
        }
        return object
    }
}
