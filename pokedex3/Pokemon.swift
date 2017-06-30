//
//  Pokemon.swift
//  pokedex3
//
//  Created by Nguyen Truong Dai Vi on 6/22/17.
//  Copyright © 2017 Nguyen Truong Dai Vi. All rights reserved.
//

import Foundation
class Pokemon {
    fileprivate var mName: String!
    fileprivate var mId: Int!
    fileprivate var mHeight: String!
    fileprivate var mWeight: String!
    fileprivate var mAttack: String!
    fileprivate var mNextEvolution: String!
    fileprivate var mDefense: String!
    fileprivate var mType: String!
    fileprivate var mDescription: String!
    
    var name: String{
        get {
            return mName
        }
        set {
            mName = newValue
        }
    }
    
    var id: Int {
        return mId
    }
    
    var height: String{
        get {
            return mHeight
        }
        set {
            mHeight = newValue
        }
    }
    
    var weight: String{
        get {
            return mWeight
        }
        set {
            mWeight = newValue
        }
    }
    
    var attack: String{
        get {
            return mAttack
        }
        set {
            mAttack = newValue
        }
    }
    
    var nextEvolution: String{
        get {
            return mNextEvolution
        }
        set {
            mNextEvolution = newValue
        }
    }
    
    var defense: String{
        get {
            return mDefense
        }
        set {
            mDefense = newValue
        }
    }
    
    var type: String{
        get {
            return mType
        }
        set {
            mType = newValue
        }
    }
    
    var description: String{
        get {
            return mDescription
        }
        set {
            mDescription = newValue
        }
    }
    
    init() {
    }
    
    init(name: String, id: Int) {
        self.mName = name
        self.mId = id
    }
}
