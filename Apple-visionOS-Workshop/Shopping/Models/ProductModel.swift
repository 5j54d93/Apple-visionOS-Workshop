//
//  ProductModel.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/12.
//

import Foundation

struct ProductModel {
    let imageName: String
    let price: Double
    let name: String
    let subheadline: String
    let description: String
    
    var usdzFileName: String {
        imageName
    }
}

extension ProductModel: Hashable {}
extension ProductModel: Codable {}

extension ProductModel: CaseIterable {
    static let allCases: [ProductModel] = [
        chairSwan,
        cupSaucerSet,
        fenderStratocaster,
        flowerTulip,
        gramophone,
        LamborghiniHuracánSTO,
        pancakes,
        robot,
        sneakerAirforce,
        sneakerPegasustrail,
        teapot,
        toyBiplane,
        toyCar,
        toyDrummer,
        tvRetro,
        wateringcan
    ]
    
    static let chairSwan = ProductModel(
        imageName: "chair_swan",
        price: 1899.99,
        name: "Swan 設計師椅",
        subheadline: "優雅與舒適的完美結合",
        description: """
            Swan 設計師椅以其流暢的弧線和人體工學設計帶來極致的舒適感。座椅採用高品質的塑料材質，搭配不銹鋼腳架，既時尚又耐用。適合辦公室、客廳或任何現代風格的空間。
            """
    )
    
    static let cupSaucerSet = ProductModel(
        imageName: "cup_saucer_set",
        price: 29.99,
        name: "經典咖啡杯與碟組",
        subheadline: "品味咖啡的極致享受",
        description: """
            這款極簡風格的咖啡杯與碟組，採用優質陶瓷燒製，手柄設計獨特，方便握持。搭配精緻的不銹鋼小湯匙，是您享受早晨咖啡時光的理想選擇。
            """
    )
    
    static let fenderStratocaster = ProductModel(
        imageName: "fender_stratocaster",
        price: 20800,
        name: "Fender Stratocaster 電吉他",
        subheadline: "塑造搖滾歷史的聲音",
        description: """
            親手觸摸音樂歷史。這把正宗的 Fender Stratocaster 不只是一把吉他，更是塑造搖滾樂數代發展的傳奇之聲。頂級 alnico 拾音器和經典 Fender 顫音系統完美重現標誌性音色，楓木琴頸和紫檀木指板的觸感讓您彷彿回到家中。以耀眼的糖果蘋果紅現身，準備譜寫您音樂旅程的下一個篇章。
            """
    )
    
    static let flowerTulip = ProductModel(
        imageName: "flower_tulip",
        price: 620,
        name: "現代鬱金香花瓶",
        subheadline: "永不褪色的永恆之美",
        description: """
            為您的空間帶來永恆的春天。這件現代傑作以珊瑚紅色花瓶為主體，迷人的紋理表面和優雅的修長形態，為其主角 – 栩栩如生且永不凋謝的白色鬱金香 – 提供完美舞台。加重底座確保穩定性，而特製的開口則同時適合人造花和鮮花擺放。這不只是裝飾品，更是永恆的春日印記。
            """
    )
    
    static let gramophone = ProductModel(
        imageName: "gramophone",
        price: 4500,
        name: "傳統留聲機",
        subheadline: "經典外觀，現代音質",
        description: """
            以全新的復古方式體驗音樂。手工製作的黃銅喇叭和質感木製底座完美重現維多利亞時代的浪漫情懷，同時內建的藍牙 5.0 技術讓您能以水晶般清晰的音質串流播放喜愛的音樂。這不僅是一台音樂播放器，更是一台能將過往優雅帶入現代播放清單的時光機器。
            """
    )
    
    static let LamborghiniHuracánSTO = ProductModel(
        imageName: "Lamborghini_Huracán_STO",
        price: 327000.00,
        name: "Lamborghini Huracán STO",
        subheadline: "終極賽道體驗",
        description: """
            Lamborghini Huracán STO 是一款專為極限速度與操控而生的超跑。搭載 5.2L V10 自然進氣引擎，輸出超過 640 匹馬力，擁有輕量化碳纖維車身與空氣力學設計，帶來賽道級的駕馭體驗。
            """
    )
    
    static let pancakes = ProductModel(
        imageName: "pancakes",
        price: 12.99,
        name: "藍莓堅果鬆餅",
        subheadline: "美味早餐的完美選擇",
        description: """
            這款手工製作的鬆餅，每一層都充滿了濃郁的香氣與綿密的口感。搭配新鮮藍莓、核桃與蜂蜜，為您帶來健康又美味的早晨享受。
            """
    )
    
    static let robot = ProductModel(
        imageName: "robot",
        price: 49.99,
        name: "復古機器人玩具",
        subheadline: "童年的經典回憶",
        description: """
            這款復古機器人玩具，擁有傳統的金屬外觀與可愛的機械設計，內建發條機械裝置，可以行走並擺動手臂，重現 80 年代的童年樂趣。
            """
    )
    
    static let sneakerAirforce = ProductModel(
        imageName: "sneaker_airforce",
        price: 129.99,
        name: "Nike Air Force 1 限量版",
        subheadline: "經典街頭潮流鞋款",
        description: """
            Nike Air Force 1 以其經典的設計與舒適的氣墊技術深受潮流人士喜愛。這款限量版搭載迷彩紋理與霓虹綠細節，完美展現個性風格。
            """
    )
    
    static let sneakerPegasustrail = ProductModel(
        imageName: "sneaker_pegasustrail",
        price: 3499,
        name: "Nike Pegasus 越野跑鞋",
        subheadline: "自信征服所有山徑",
        description: """
            下一條山徑將帶您去向何方？有了 Nike Pegasus 越野跑鞋，答案就是：只要您敢想像的任何地方。搭載 Nike 革命性的 React 緩震科技和具侵略性的潑墨鞋底，這雙鞋能將障礙化為機遇。適應性網布鞋面和強化鞋頭提供全方位防護，而透氣科技和反光細節則確保您的冒險不會因日落而停止。
            """
    )
    
    static let teapot = ProductModel(
        imageName: "teapot",
        price: 39.99,
        name: "復古琺瑯茶壺",
        subheadline: "傳統工藝與經典設計",
        description: """
            這款琺瑯茶壺擁有手工打造的木柄與金屬細節，完美適合沖泡各類茶飲。其懷舊的外觀讓人回味無窮，成為家居裝飾的一部分。
            """
    )
    
    static let toyBiplane = ProductModel(
        imageName: "toy_biplane",
        price: 990,
        name: "復古玩具雙翼飛機",
        subheadline: "復古魅力遇上經典航空",
        description: """
            與這架精緻做舊的金屬玩具雙翼機一同重返往日時光。薄荷綠與黃色的塗裝，搭配醒目的斜紋條紋，喚起特技飛行員與空戰英雄的黃金年代。每架模型都配備可轉動的螺旋槳，經過精心做舊處理，訴說著想像中的飛行冒險故事。無論是收藏家、航空愛好者，或任何嚮往藍天的人，都會為之著迷。
            """
    )
    
    static let toyCar = ProductModel(
        imageName: "toy_car",
        price: 24.99,
        name: "復古賽車玩具",
        subheadline: "金屬工藝經典收藏",
        description: """
            這款仿復古風格的玩具車，擁有經典的流線造型與鮮豔色彩，適合作為收藏品或兒童玩具，為您帶來懷舊的駕駛樂趣。
            """
    )
    
    static let toyDrummer = ProductModel(
        imageName: "toy_drummer",
        price: 34.99,
        name: "發條鼓手玩具",
        subheadline: "敲擊節奏，帶來快樂",
        description: """
            這款可愛的發條鼓手，旋轉發條後便會敲擊小鼓，展現趣味十足的動作。適合小朋友的音樂啟蒙，亦是懷舊收藏的佳品。
            """
    )
    
    static let tvRetro = ProductModel(
        imageName: "tv_retro",
        price: 9900,
        name: "復古電視機",
        subheadline: "昨日風格，今日科技",
        description: """
            重現 1960 年代的迷人魅力。在這款真實木紋機櫃和復古造型背後，藏著一個現代奇蹟 – 可自訂的數位顯示螢幕，以中世紀風格展現您的內容。從經典測試畫面到最新的數位藝術，HDMI 和 USB 連接確保您的回憶以完美復古的方式呈現。這不只是一件談話焦點，更是一個重新演繹的時光膠囊。
            """
    )
    
    static let wateringcan = ProductModel(
        imageName: "wateringcan",
        price: 19.99,
        name: "工業風澆花壺",
        subheadline: "經典設計，耐用材質",
        description: """
            這款工業風格的澆花壺，採用金屬材質與霧黑塗裝，適用於室內外澆水，亦可作為園藝裝飾的一部分。
            """
    )
}
