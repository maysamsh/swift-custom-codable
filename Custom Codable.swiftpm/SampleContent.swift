import Foundation

struct SamplePayload: Codable {   
    let name, sku: String?
    let price: Double?
    let shipTo: ShipTo?
    let billTo: BillTo?
    
    struct ShipTo: Codable {
        let name, address, city, state: String?
        let zip: String?
    }
    
    struct BillTo: Codable {
        let name, address, city, state, zip: String?
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SamplePayload.CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: SamplePayload.CodingKeys.name)
        self.sku = try container.decodeIfPresent(String.self, forKey: SamplePayload.CodingKeys.sku)
        self.price = try container.decodeIfPresent(Double.self, forKey: SamplePayload.CodingKeys.price)
        self.shipTo = try container.decodeIfPresent(ShipTo.self, forKey: SamplePayload.CodingKeys.shipTo)
        let billToString = try container.decodeIfPresent(String.self, forKey: SamplePayload.CodingKeys.billTo)
        let jsonDecoder = JSONDecoder()
        if let data = billToString?.data(using: .utf8), let billToDecoded = try? jsonDecoder.decode(BillTo.self, from: data) {
            self.billTo = billToDecoded
        } else {
            self.billTo = nil
        }
    }
}
