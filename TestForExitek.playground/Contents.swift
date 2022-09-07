// Implement mobile phone storage protocol
// Requirements:
// - Mobiles must be unique (IMEI is an unique number)
// - Mobiles must be stored in memory
protocol MobileStorage {
    func getAll() -> Set<Mobile>
    func findByImei(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
}

struct Mobile: Hashable {
    let imei: String
    let model: String
}

enum MobileErrors: Error {
    case requestedPhoneIsNotFound
    case requestedPhoneIsExist
}


class StorageMobileImplement: MobileStorage {
    
    private var mobileProduct = Set<Mobile>()
    
    func getAll() -> Set<Mobile> {
        return mobileProduct
    }
    
    func findByImei(_ imei: String) -> Mobile? {
        for product in mobileProduct {
            if product.imei == imei {
                return product
            }
        }
        return nil
    }
    
    func save(_ mobile: Mobile) throws -> Mobile {
        if mobileProduct.contains(mobile) {
            MobileErrors.requestedPhoneIsExist
        }
        mobileProduct.insert(mobile)
        return mobile
    }
    
    func delete(_ product: Mobile) throws {
        if !mobileProduct.contains(product) {
            MobileErrors.requestedPhoneIsNotFound
        }
        mobileProduct.remove(product)
    }
    
    func exists(_ product: Mobile) -> Bool {
        mobileProduct.contains(product)
    }
}
