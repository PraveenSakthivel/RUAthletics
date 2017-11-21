//
//  NewsArticle.swift
//  RUAthletics
//
//  Created by Praveen Sakthivel on 11/15/17.
//  Copyright © 2017 TBLE Technologies. All rights reserved.
//

import Foundation
class NewsArticle{
    var title: String = String()
    var description: String = String()
    var tags = [StringKeyPair]()
    var link: String = String()
    init(titleParam: String, descParam: String){
        title = titleParam
        description = descParam
    }
    init(){
        
    }
}
