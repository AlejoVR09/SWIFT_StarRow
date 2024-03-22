//
//  AooUserCoreData.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 21/03/24.
//

import Foundation
import UIKit

struct AppUserCoreDataProvider {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     
    func saveUser(withEmail: String, withName: String, withPhone: String) -> Bool {
        let user = AppUser(context: self.context)
        user.email = withEmail
        user.name = withName
        user.phone = withPhone
        do {
            try self.context.save()
            UserSession.currentSessionProfile(currentUserEmail: withEmail)
            return true
        }
        catch{
            return false
        }
    }
    
    func saveMovieInUser(currentUser: AppUser?, movie: MovieCoreData){
        currentUser?.addToFavorites(movie)
        do {
            try self.context.save()
        }
        catch{
            print(error)
        }
    }
    
    func retrieveUser(email: String) -> AppUser? {
        let users = self.retrieveData()
        let result = users.first { $0.email == email }
        guard let result = result else { return nil }
        return result
    }
    
    func retrieveData() -> [AppUser]{
        do{
            let users = try self.context.fetch(AppUser.fetchRequest())
            return users
        }
        catch {
            return []
        }
    }
    
    func verifyExistingUser(email: String) -> Bool {
        let users = self.retrieveData()
        let result = users.first { $0.email == email }
        guard result != nil else { return true }
        return false
    }
}
