// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cardSearchResult = try? newJSONDecoder().decode(CardSearchResult.self, from: jsonData)

import Foundation

// MARK: - CardSearchResult
struct CardSearchResult: Codable {
  var object: String
  var totalCards: Int
  var hasMore: Bool
  var nextPage: String?
  var cards: [MagicCard]

  enum CodingKeys: String, CodingKey {
    case object
    case totalCards = "total_cards"
    case hasMore = "has_more"
    case nextPage = "next_page"
    case cards = "data"
  }
}

// MARK: - MagicCard
struct MagicCard: Codable, Identifiable {
  var object: DatumObject
  var id, oracleID: String
  var multiverseIDS: [Int]
  var tcgplayerID: Int?
  var name: String
  var lang: Lang
  var releasedAt: String
  var uri, scryfallURI: String
  var layout: String
  var highresImage: Bool
  var imageUris: ImageUris?
  var manaCost: String?
  var cmc: Int
  var typeLine: String
  var oracleText, power, toughness: String?
  var colors, colorIndicator: [Color]?
  var colorIdentity: [Color]
  var legalities: Legalities
  var games: [Game]
  var reserved, foil, nonfoil, oversized: Bool
  var promo, reprint, variation: Bool
  var datumSet, setName: String
  var setType: String
  var setURI, setSearchURI, scryfallSetURI, rulingsURI: String
  var printsSearchURI: String
  var collectorNumber: String
  var digital: Bool
  var rarity: Rarity
  var cardBackID, artist: String
  var artistIDS: [String]
  var illustrationID: String?
  var borderColor: BorderColor
  var frame: String
  var fullArt, textless, booster, storySpotlight: Bool
  var prices: [String: String?]
  var relatedUris: RelatedUris
  var purchaseUris: PurchaseUris
  var flavorText: String?
  var edhrecRank, mtgoID, mtgoFoilID: Int?
  var cardFaces: [CardFace]?
  var frameEffects: [String]?
  var arenaID: Int?
  var watermark: String?
  var preview: Preview?
  var promoTypes: [String]?
  var allParts: [AllPart]?

  enum CodingKeys: String, CodingKey {
    case object, id
    case oracleID = "oracle_id"
    case multiverseIDS = "multiverse_ids"
    case tcgplayerID = "tcgplayer_id"
    case name, lang
    case releasedAt = "released_at"
    case uri
    case scryfallURI = "scryfall_uri"
    case layout
    case highresImage = "highres_image"
    case imageUris = "image_uris"
    case manaCost = "mana_cost"
    case cmc
    case typeLine = "type_line"
    case oracleText = "oracle_text"
    case power, toughness, colors
    case colorIndicator = "color_indicator"
    case colorIdentity = "color_identity"
    case legalities, games, reserved, foil, nonfoil, oversized, promo, reprint, variation
    case datumSet = "set"
    case setName = "set_name"
    case setType = "set_type"
    case setURI = "set_uri"
    case setSearchURI = "set_search_uri"
    case scryfallSetURI = "scryfall_set_uri"
    case rulingsURI = "rulings_uri"
    case printsSearchURI = "prints_search_uri"
    case collectorNumber = "collector_number"
    case digital, rarity
    case cardBackID = "card_back_id"
    case artist
    case artistIDS = "artist_ids"
    case illustrationID = "illustration_id"
    case borderColor = "border_color"
    case frame
    case fullArt = "full_art"
    case textless, booster
    case storySpotlight = "story_spotlight"
    case prices
    case relatedUris = "related_uris"
    case purchaseUris = "purchase_uris"
    case flavorText = "flavor_text"
    case edhrecRank = "edhrec_rank"
    case mtgoID = "mtgo_id"
    case mtgoFoilID = "mtgo_foil_id"
    case cardFaces = "card_faces"
    case frameEffects = "frame_effects"
    case arenaID = "arena_id"
    case watermark, preview
    case promoTypes = "promo_types"
    case allParts = "all_parts"
  }
}

// MARK: - AllPart
struct AllPart: Codable {
  var object, id, component, name: String
  var typeLine: String
  var uri: String

  enum CodingKeys: String, CodingKey {
    case object, id, component, name
    case typeLine = "type_line"
    case uri
  }
}

enum BorderColor: String, Codable {
  case black = "black"
  case silver = "silver"
  case white = "white"
}

// MARK: - CardFace
struct CardFace: Codable {
  var object: CardFaceObject
  var name, manaCost, typeLine, oracleText: String
  var colors: [Color]?
  var power, toughness, flavorText: String?
  var artist, artistID: String
  var illustrationID: String?
  var imageUris: ImageUris?
  var colorIndicator: [Color]?

  enum CodingKeys: String, CodingKey {
    case object, name
    case manaCost = "mana_cost"
    case typeLine = "type_line"
    case oracleText = "oracle_text"
    case colors, power, toughness
    case flavorText = "flavor_text"
    case artist
    case artistID = "artist_id"
    case illustrationID = "illustration_id"
    case imageUris = "image_uris"
    case colorIndicator = "color_indicator"
  }
}

enum Color: String, Codable {
  case b = "B"
  case g = "G"
  case r = "R"
  case u = "U"
  case w = "W"
}

// MARK: - ImageUris
struct ImageUris: Codable {
  var small, normal, large: String
  var png: String
  var artCrop, borderCrop: String

  enum CodingKeys: String, CodingKey {
    case small, normal, large, png
    case artCrop = "art_crop"
    case borderCrop = "border_crop"
  }
}

enum CardFaceObject: String, Codable {
  case cardFace = "card_face"
}

enum Game: String, Codable {
  case arena = "arena"
  case mtgo = "mtgo"
  case paper = "paper"
}

enum Lang: String, Codable {
  case en = "en"
}


// MARK: - Legalities
struct Legalities: Codable {
  var standard, future, historic, pioneer: Brawl
  var modern, legacy, pauper, vintage: Brawl
  var penny, commander, brawl: Brawl
  var duel: Duel
  var oldschool: Brawl
}

enum Brawl: String, Codable {
  case banned = "banned"
  case legal = "legal"
  case notLegal = "not_legal"
}

enum Duel: String, Codable {
  case legal = "legal"
  case notLegal = "not_legal"
  case restricted = "restricted"
}

enum DatumObject: String, Codable {
  case card = "card"
}

// MARK: - Preview
struct Preview: Codable {
  var source: String
  var sourceURI: String
  var previewedAt: String

  enum CodingKeys: String, CodingKey {
    case source
    case sourceURI = "source_uri"
    case previewedAt = "previewed_at"
  }
}

// MARK: - PurchaseUris
struct PurchaseUris: Codable {
  var tcgplayer, cardmarket, cardhoarder: String
}

enum Rarity: String, Codable {
  case common = "common"
  case mythic = "mythic"
  case rare = "rare"
  case uncommon = "uncommon"
}

// MARK: - RelatedUris
struct RelatedUris: Codable {
  var gatherer: String?
  var tcgplayerDecks, edhrec, mtgtop8: String

  enum CodingKeys: String, CodingKey {
    case gatherer
    case tcgplayerDecks = "tcgplayer_decks"
    case edhrec, mtgtop8
  }
}

