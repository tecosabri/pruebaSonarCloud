//
//  Hero.swift
//  iOSSuperPoderes
//
//  Created by Ismael Sabri Pérez on 24/7/23.
//


import Foundation

struct Hero: Identifiable, Decodable {
    let photo: String
    let id: String
    let name: String
    let description: String
}
