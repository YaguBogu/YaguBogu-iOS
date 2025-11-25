// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let game = try? JSONDecoder().decode(Game.self, from: jsonData)

import Foundation

// MARK: - Game
struct GameInfo: Codable {
    let gameGet: String
    let parameters: Parameters
    let errors: [JSONAny]
    let results: Int
    let response: [GameInfoResponse]

    enum CodingKeys: String, CodingKey {
        case gameGet = "get"
        case parameters, errors, results, response
    }
}

// MARK: - Parameters
struct Parameters: Codable {
    let league, season, team: String
}

// MARK: - Response
struct GameInfoResponse: Codable {
    let id: Int
    let date: Date
    let time: Time
    let timestamp: Int
    let timezone: Timezone
    let week: String?
    let status: Status
    let country: Country
    let league: League
    let teams: Teams
    let scores: Scores
}

// MARK: - Country
struct Country: Codable {
    let id: Int
    let name: CountryName
    let code: Code
    let flag: String
}

enum Code: String, Codable {
    case kr = "KR"
}

enum CountryName: String, Codable {
    case southKorea = "South-Korea"
}

// MARK: - League
struct League: Codable {
    let id: Int
    let name: LeagueName
    let type: TypeEnum
    let logo: String
    let season: Int
}

enum LeagueName: String, Codable {
    case kbo = "KBO"
}

enum TypeEnum: String, Codable {
    case league = "League"
}

// MARK: - Scores
struct Scores: Codable {
    let home, away: ScoresAway
}

// MARK: - ScoresAway
struct ScoresAway: Codable {
    let hits, errors: Int?
    let innings: Innings
    let total: Int?
}

// MARK: - Innings
struct Innings: Codable {
    let the1, the2, the3, the4: Int?
    let the5, the6, the7, the8: Int?
    let the9, extra: Int?

    enum CodingKeys: String, CodingKey {
        case the1 = "1"
        case the2 = "2"
        case the3 = "3"
        case the4 = "4"
        case the5 = "5"
        case the6 = "6"
        case the7 = "7"
        case the8 = "8"
        case the9 = "9"
        case extra
    }
}

// MARK: - Status
struct Status: Codable {
    let long: Long
    let short: Short
}

enum Long: String, Codable {
    case cancelled = "Cancelled"
    case finished = "Finished"
    case postponed = "Postponed"
}

enum Short: String, Codable {
    case canc = "CANC"
    case ft = "FT"
    case post = "POST"
}

// MARK: - Teams
struct Teams: Codable {
    let home, away: TeamsAway
}

// MARK: - TeamsAway
struct TeamsAway: Codable {
    let id: Int
    let name: AwayName
    let logo: String
}

enum AwayName: String, Codable {
    case doosanBears = "Doosan Bears"
    case hanwhaEagles = "Hanwha Eagles"
    case kiaTigers = "KIA Tigers"
    case kiwoomHeroes = "Kiwoom Heroes"
    case ktWizSuwon = "KT Wiz Suwon"
    case lgTwins = "LG Twins"
    case lotteGiants = "Lotte Giants"
    case ncDinos = "NC Dinos"
    case samsungLions = "Samsung Lions"
    case ssgLanders = "SSG Landers"
}

enum Time: String, Codable {
    case the0400 = "04:00"
    case the0500 = "05:00"
    case the0800 = "08:00"
    case the0900 = "09:00"
    case the0930 = "09:30"
}

enum Timezone: String, Codable {
    case utc = "UTC"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
            return nil
    }

    required init?(stringValue: String) {
            key = stringValue
    }

    var intValue: Int? {
            return nil
    }

    var stringValue: String {
            return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
            return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if container.decodeNil() {
                    return JSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if let value = try? container.decodeNil() {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
            if let value = try? container.decode(Bool.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Int64.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Double.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(String.self, forKey: key) {
                    return value
            }
            if let value = try? container.decodeNil(forKey: key) {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                    let value = try decode(from: &container)
                    arr.append(value)
            }
            return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                    let value = try decode(from: &container, forKey: key)
                    dict[key.stringValue] = value
            }
            return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                    if let value = value as? Bool {
                            try container.encode(value)
                    } else if let value = value as? Int64 {
                            try container.encode(value)
                    } else if let value = value as? Double {
                            try container.encode(value)
                    } else if let value = value as? String {
                            try container.encode(value)
                    } else if value is JSONNull {
                            try container.encodeNil()
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer()
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                    let key = JSONCodingKey(stringValue: key)!
                    if let value = value as? Bool {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Int64 {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Double {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? String {
                            try container.encode(value, forKey: key)
                    } else if value is JSONNull {
                            try container.encodeNil(forKey: key)
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer(forKey: key)
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
            if let value = value as? Bool {
                    try container.encode(value)
            } else if let value = value as? Int64 {
                    try container.encode(value)
            } else if let value = value as? Double {
                    try container.encode(value)
            } else if let value = value as? String {
                    try container.encode(value)
            } else if value is JSONNull {
                    try container.encodeNil()
            } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
            }
    }

    public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                    self.value = try JSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
                    self.value = try JSONAny.decodeDictionary(from: &container)
            } else {
                    let container = try decoder.singleValueContainer()
                    self.value = try JSONAny.decode(from: container)
            }
    }

    public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                    var container = encoder.unkeyedContainer()
                    try JSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                    var container = encoder.container(keyedBy: JSONCodingKey.self)
                    try JSONAny.encode(to: &container, dictionary: dict)
            } else {
                    var container = encoder.singleValueContainer()
                    try JSONAny.encode(to: &container, value: self.value)
            }
    }
}
