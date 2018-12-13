//
//  City.swift
//  Travel App
//
//  Created by Milan Patel on 9/24/18.
//  Copyright © 2018 Milan Patel. All rights reserved.
//

import Foundation

class Cities {
    var cityList:[City] = []
    init () {
        let city1 = City(cn: "Denver, CO", cd: "A city located in Colorado that is known for the Red Rocks Amphitheatre", cim: "denver.png")
        let city2 = City(cn: "Sedona, AZ", cd: "City with red colored rocks, right outside of Flagstaff.", cim: "sedona")
        let city3 = City(cn: "Moab, UT", cd: "A city located in Utah known for its mountain biking and off roading trails.", cim: "moab.png")
        let city4 = City(cn: "Los Angeles, CA", cd: "One of most busy cities in the USA locatedin California.", cim: "losangeles.png")
        let city5 = City(cn: "Tucson, AZ", cd: "A city south of Phonenix that is home to the Univeristy of Arizona.", cim: "tucson.png")
        
        cityList.append(city1)
        cityList.append(city2)
        cityList.append(city3)
        cityList.append(city4)
        cityList.append(city5)
    }
}

class City {
    var cityName:String?
    var cityDescription:String?
    var cityImage:String?
    
    init (cn:String, cd:String, cim:String ) {
        cityName = cn
        cityDescription = cd
        cityImage = cim
    }
}
