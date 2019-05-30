//
//  DataCenter.swift
//  SmartOrder
//
//  Created by 하영 on 2019. 4. 18..
//  Copyright © 2019년 하영. All rights reserved.
//

import Foundation

//메뉴
struct Menu {
    var menuId:Int
    var coffee:String //음료이름
    var image:String? //음료사진
    var price:Int //음료가격
    var shot : Bool
    var isLiked : Bool
    
    init(menuId:Int, coffee: String, image: String?, price : Int, shot : Bool){
        self.coffee = coffee
        self.image = image
        self.price = price
        self.shot = shot
        self.menuId = menuId
        isLiked = false
    }
}

struct UserInfo {
    var name: String
    var id: String
    var joinAddress: String
    var orderList : OrderList
    //var likeList : //타입이랑 변수 선언 후 초기화메서드까지 작성 부탁드립니다.
    //var stampList
    //var couponList
    
    init(name: String?, id: String?, joinAddress: String?){
        self.name = name!
        self.id = id!
        self.joinAddress = joinAddress!
        self.orderList = OrderList(title: "User", orders:[])
    }
    
    init(){
        self.name = ""
        self.id = ""
        self.joinAddress  = ""
        self.orderList = OrderList(title: "User", orders:[])
    }
}

// 유저 정보 최종 저장 프로퍼티
var currentUserInfo : UserInfo = UserInfo()

// 로그인된 유저 정보(카카오)를 들고있는 프로퍼티
var loginUserInfo : KOUserMe?

// 유저가 주문했던 정보를 들고있는 프로퍼티
var userOrdered : OrderList = OrderList(title: "Test", orders:[ordertest])
var ordertest = Order(caffeInfo:caffe1.caffeInfo, coffee:"카페라떼", price:2500, count:1, size:"small", ice:"보통", shot:0, orderDate:"19.03.30")

var moca = Menu(menuId:0, coffee:"카페모카", image:nil, price:3500, shot:true)
var latte = Menu(menuId:1, coffee:"카페라떼", image:nil, price:2500, shot:true)
var iceLatte = Menu(menuId:2, coffee:"아이스카페라떼", image:nil, price:2500, shot:true)
var macchiatos = Menu(menuId:3,coffee:"카라멜마끼야또", image:nil, price:3500, shot:true)
var iceAmericano = Menu(menuId:4,coffee:"아메리카노", image:nil, price:1800, shot:true)
var Americano = Menu(menuId:5,coffee:"아이스아메리카노", image:nil, price:1500, shot:true)
var chocolate = Menu(menuId:6,coffee:"핫초코", image:nil, price:3000, shot:false)
var iceChocolate = Menu(menuId:7,coffee:"아이스초코", image:nil, price:3500, shot:false)
var iceteaL = Menu(menuId:8, coffee:"아이스티레몬", image:nil, price:3000, shot:false)
var iceteaP = Menu(menuId:9, coffee:"아이스티복숭아", image:nil, price:3000, shot:false)

var MenuSubscript:[Int:Menu] = [moca.menuId:moca,latte.menuId:latte,iceLatte.menuId:iceLatte,macchiatos.menuId:macchiatos,iceAmericano.menuId:iceAmericano,Americano.menuId:Americano,chocolate.menuId:chocolate,iceChocolate.menuId:iceChocolate,iceteaL.menuId:iceteaL,iceteaP.menuId:iceteaP]

var macchiatos2 = Menu(menuId:0,coffee:"카라멜마끼야또", image:nil, price:3500, shot:true)
var iceAmericano2 = Menu(menuId:1,coffee:"아메리카노", image:nil, price:1800, shot:true)
var Americano2 = Menu(menuId:2,coffee:"아이스아메리카노", image:nil, price:1500, shot:true)

var MenuSubscript2:[Int:Menu] = [macchiatos2.menuId:macchiatos2,iceAmericano2.menuId:iceAmericano2,Americano2.menuId:Americano2]

var iceAmericano3 = Menu(menuId:0,coffee:"아메리카노", image:nil, price:1800, shot:true)
var Americano3 = Menu(menuId:1,coffee:"아이스아메리카노", image:nil, price:1500, shot:true)
var chocolate3 = Menu(menuId:2,coffee:"핫초코", image:nil, price:3000, shot:false)
var iceChocolate3 = Menu(menuId:3,coffee:"아이스초코", image:nil, price:3500, shot:false)
var iceteaL3 = Menu(menuId:4, coffee:"아이스티레몬", image:nil, price:3000, shot:false)
var iceteaP3 = Menu(menuId:5, coffee:"아이스티복숭아", image:nil, price:3000, shot:false)

var MenuSubscript3:[Int:Menu] = [iceAmericano3.menuId:iceAmericano3,Americano3.menuId:Americano3,chocolate3.menuId:chocolate3,iceChocolate3.menuId:iceChocolate3,iceteaL3.menuId:iceteaL3,iceteaP3.menuId:iceteaP3]

//카페
struct Caffe {
    var caffeInfo:Int //카페 고유넘버
    var logo:String? //카페 로고
    var photo:String? //카페 내부 사진
    var name:String //카페이름
    var location:String //카페위치
    var menu:[Int:Menu]
    var stampToCoupon:Int
    var sizeUp:Int //Large 추가 금액
    var shotPrice:Int // shot 추가 금액
}

var caffe1 = Caffe(caffeInfo:0, logo:"queue", photo:"queueIn", name:"카페큐", location:"한양대학교 산학기술관(IT/BT관) 3층 로비", menu:MenuSubscript, stampToCoupon:10, sizeUp:500, shotPrice:500)

var caffe2 = Caffe(caffeInfo:1, logo: "tiamo", photo:"tiamo_photo.JPG", name:"TIAMO MK점", location:"한양대학교 노천", menu:MenuSubscript2, stampToCoupon:10, sizeUp:500, shotPrice:400)
var caffe3 = Caffe(caffeInfo:2, logo: "tiamo", photo:nil, name:"TIAMO 학술정보관점", location:"제2공학관", menu:MenuSubscript3, stampToCoupon:10, sizeUp:500, shotPrice:400)

var caffeList:[Int:Caffe] = [caffe1.caffeInfo:caffe1, caffe2.caffeInfo:caffe2, caffe3.caffeInfo:caffe3]


//주문
struct Order {
    var caffeInfo:Int
    var coffee:String //주문한 음료
    var price:Int //음료 가격
    var count:Int //음료 수량
    var size:String //음료 사이즈
    var ice:String //음료 얼음양
    var shot:Int// 샷추가
    var orderDate:String
}

var order1 = Order(caffeInfo:caffe1.caffeInfo, coffee:"카페라떼", price:2500, count:1, size:"small", ice:"보통", shot:0, orderDate:"2019.03.30")
var order2 = Order(caffeInfo:caffe1.caffeInfo, coffee:"아이스아메리카노", price:1800, count:1, size:"small", ice:"보통", shot:0, orderDate:"2019.04.30")


//담기
struct cart {
    var selectedMenu:[Order]
}

var selected1 = order1
var selected2 = order2

//장바구니
var myCart = cart(selectedMenu: [])
var cartSelectedArray:[Int] = []

//주문내역
struct OrderList {
    var title:String
    var orders: [Order]
    mutating func addOrder(_ item:Order){
        self.orders.append(item)
    }
}

var list = OrderList(title:"03월", orders:[])


//내가 방문한 카페
struct MyCaffe {
    var caffe:String //내가 방문한 카페
    var stampCount:Int //적립받은 스탬프 누적갯수
    mutating func addCount(_ param:Int){
        if param < 0 {
            if self.stampCount >= 10 { //스탬프가 10개 => 쿠폰발행
                self.stampCount += param
                print("쿠폰 발행 성공")
            }else {
                print("스탬프 갯수 부족으로 쿠폰 발행 실패")
            }
        }else {
            self.stampCount += param
            print("스탬프 적립 성공")
        }
    }
}

//var queueCaffe = MyCaffe(caffe:"카페큐", stampCount:0)
var queueCaffe = MyCaffe(caffe:caffe1.name, stampCount:0)

//스탬프
struct Stamp {
    var issueDate:String //스탬프(적립/사용)날짜
    var caffeInfo:Int //스탬프(적립/사용)한 카페 정보 - 고유넘버
    var count:Int //(적립/사용)한 스탬프 개수
    var info:String //(적립/사용)
    
    mutating func stampCounter(_ param:Int) {
        if self.caffeInfo == 0 { // queue 카페인 경우 queue 카페 스탬프 수 증가.
            queueCaffe.addCount(count)
        }
    }
}


//var stamp1 = Stamp(issueDate:"2019-03-29", caffe:"카페큐", count:1, info:"적립")
//stamp1.stampCounter(stamp1.count)
//var stamp2 = Stamp(issueDate:"2019-03-29", caffe:"카페큐", count:-10, info:"사용(쿠폰발행)")
//stamp2.stampCounter(stamp2.count)
/*
var stamp3 = Stamp(issueDate:"2019-04-30", caffe:"카페큐", count:1, info:"적립")
var stamp4 = Stamp(issueDate:"2019-05-01", caffe:"카페큐", count:1, info:"적립")
var stamp5 = Stamp(issueDate:"2019-05-02", caffe:"카페큐", count:1, info:"적립")
var stamp6 = Stamp(issueDate:"2019-05-03", caffe:"카페큐", count:1, info:"적립")
var stamp7 = Stamp(issueDate:"2019-05-04", caffe:"카페큐", count:1, info:"적립")
*/
var stamp1 = Stamp(issueDate:order1.orderDate, caffeInfo: order1.caffeInfo, count: order1.count, info: "적립")
var stamp2 = Stamp(issueDate:order1.orderDate, caffeInfo: order1.caffeInfo, count: order1.count, info: "적립")
var stamp3 = Stamp(issueDate:order1.orderDate, caffeInfo: order1.caffeInfo, count: order1.count, info: "적립")
var stamp4 = Stamp(issueDate:order1.orderDate, caffeInfo: order1.caffeInfo, count: order1.count, info: "적립")
var stamp5 = Stamp(issueDate:order1.orderDate, caffeInfo: order1.caffeInfo, count: order1.count, info: "적립")
var stamp6 = Stamp(issueDate:order1.orderDate, caffeInfo: order1.caffeInfo, count: order1.count, info: "적립")
var stamp7 = Stamp(issueDate:order1.orderDate, caffeInfo: order1.caffeInfo, count: order1.count, info: "적립")
var stampList:[Stamp] = [stamp1,stamp2,stamp3,stamp4,stamp5,stamp6,stamp7]



//쿠폰(음료쿠폰 or 할인쿠폰)
struct Coupon {
    var name:String //쿠폰 이름 (ex. 음료명 or 할인쿠폰)
    var caffe:String //쿠폰을 사용할 수 있는 카페 이름
    var price:Int
    var issueDate:String //쿠폰 발급 일자
    var expireDate:String //쿠폰 만료 일자
    var use:Bool //쿠폰 사용 여부 (ex. 사용 true, 미사용 false)
    
    init(name: String, caffe: String, price: Int, issueDate: String, expireDate: String, use:Bool){
        self.name = name
        self.caffe = caffe
        self.price = price
        self.issueDate = issueDate
        self.expireDate = expireDate
        self.use = use
    }
}

var coupon1 = Coupon(name:"아이스아메리카노", caffe:"QUEUE", price:1800, issueDate:"2019.04.01", expireDate:"2019.05.01", use:true)
var coupon2 = Coupon(name:"2000원 할인쿠폰", caffe:"QUEUE", price:2000, issueDate:"2019.04.03", expireDate:"2019.05.03", use:false)

//쿠폰 리스트
struct CouponList {
    var coupons: [Coupon]
    
    mutating func addCoupon(_ cp:Coupon) {
        self.coupons.append(cp)
    }
}

var couponList = CouponList(coupons:[coupon1,coupon2])

//couponList.addCoupon(coupon1)
//couponList.addCoupon(coupon2)

//선호 메뉴
var MyMenu : [[Menu]] = [];
