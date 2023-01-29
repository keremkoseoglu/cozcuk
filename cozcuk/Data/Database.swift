//
//  Database.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 27.08.2022.
//

import Foundation

class Database {
    private static let STAT_PREFIX  : String    = "STAT_"
    private static let BOOL_PREFIX  : String    = "BOOL_"
    private static var SINGLETON    : Database?
    
    public static func getInstance() -> Database {
        if Database.SINGLETON == nil {
            Database.SINGLETON = Database()
        }
        return Database.SINGLETON!
    }
    
    public func getStatistic(type: StatisticType) -> Statistic {
        let key = buildStatKey(type: type)
        let val = UserDefaults.standard.integer(forKey: key)
        return Statistic(type: type, value: Int32(val))
    }
    
    public func setStatistic(_ statistic: Statistic) {
        let key = buildStatKey(type: statistic.type)
        UserDefaults.standard.set(statistic.value, forKey: key)
    }
    
    public func incrementStatistic(type: StatisticType) {
        var statistic = getStatistic(type: type)
        statistic.value += 1
        setStatistic(statistic)
    }
    
    public func resetStatistics() {
        for statisticType in StatisticType.allCases {
            if statisticType.persistent {continue}
            setStatistic(Statistic(type: statisticType, value: 0))
        }
    }
    
    public func getBool(_ name: String) -> Bool {
        let key = buildBoolKey(name)
        let val = UserDefaults.standard.integer(forKey: key)
        return val == 1
    }
    
    public func setBool(_ name: String, _ value: Bool) {
        let val: Int = value ? 1 : 0
        let key = buildBoolKey(name)
        UserDefaults.standard.set(val, forKey: key)
    }
    
    private init() {}
    
    private func buildStatKey(type: StatisticType) -> String {
        return "\(Database.STAT_PREFIX)\(type.rawValue)"
    }
    
    private func buildBoolKey(_ name: String) -> String {
        return "\(Database.BOOL_PREFIX)\(name)"
    }
}
