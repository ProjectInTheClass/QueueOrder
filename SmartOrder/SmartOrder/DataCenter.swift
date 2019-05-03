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
    var coffee:String //음료이름
    var image:String? //음료사진
    var price:Int //음료가격
}

var moca = Menu(coffee:"카페모카", image:nil, price:3500)
var latte = Menu(coffee:"카페라떼", image:nil, price:2500)
var iceLatte = Menu(coffee:"아이스카페라떼", image:nil, price:2500)
var macchiatos = Menu(coffee:"카라멜마끼야또", image:nil, price:3500)
var iceAmericano = Menu(coffee:"아메리카노", image:nil, price:1800)
var Americano = Menu(coffee:"아이스아메리카노", image:nil, price:1500)
var chocolate = Menu(coffee:"핫초코", image:nil, price:3000)
var iceChocolate = Menu(coffee:"아이스초코", image:nil, price:3500)
var iceteaL = Menu(coffee:"아이스티레몬", image:nil, price:3000)
var iceteaP = Menu(coffee:"아이스티복숭아", image:nil, price:3000)

let MenuSubscript:[Menu] = [moca,latte,iceLatte,macchiatos,iceAmericano,Americano,chocolate,iceChocolate,iceteaL,iceteaP]

//카페
struct Caffe {
    var caffeInfo:Int //카페 고유넘버
    var logo:String? //카페 로고
    var photo:String? //카페 내부 사진
    var name:String //카페이름
    var location:String //카페위치
    var menu:[Menu]
    var stampToCoupon:Int
}

var caffe1 = Caffe(caffeInfo:0, logo:nil, photo:nil, name:"카페큐", location:"ITBI관 3층", menu:MenuSubscript, stampToCoupon:10)
var caffe2 = Caffe(caffeInfo:1, logo:nil, photo:nil, name:"띠아모", location:"ITBI관 3층", menu:MenuSubscript, stampToCoupon:10)

var caffeList:[Int:String] = [caffe1.caffeInfo:caffe1.name, caffe2.caffeInfo:caffe2.name]

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

var order1 = Order(caffeInfo:caffe1.caffeInfo, coffee:"카페라떼", price:2500, count:1, size:"small", ice:"보통", shot:0, orderDate:"2019-03-30")
var order2 = Order(caffeInfo:caffe1.caffeInfo, coffee:"아이스아메리카노", price:1800, count:1, size:"small", ice:"보통", shot:0, orderDate:"2019-04-30")


//담기
struct cart {
    var selectedMenu:[Order]
}

var selected1 = order1

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
}

var coupon1 = Coupon(name:"아이스아메리카노", caffe:"QUEUE", price:1800, issueDate:"2019-04-01", expireDate:"2019-05-01", use:true)
var coupon2 = Coupon(name:"2000원 할인쿠폰", caffe:"QUEUE", price:2000, issueDate:"2019-04-03", expireDate:"2019-05-03", use:false)

//쿠폰 리스트
struct CouponList {
    var coupons: [Coupon]
    
    mutating func addCoupon(_ cp:Coupon) {
        self.coupons.append(cp)
    }
}

var couponList1 = CouponList(coupons:[])
//couponList1.addCoupon(coupon1)
//couponList1.addCoupon(coupon2)
