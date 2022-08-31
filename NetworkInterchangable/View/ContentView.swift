//
//  ContentView.swift
//  NetworkInterchangable
//
//  Created by Tunahan on 8/19/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject  var userListViewModel : UserListViewModel
    
    //MARK: Initialize
    init () {
        self.userListViewModel = UserListViewModel(service: Webservice())
    }
    
    var body: some View {
        NavigationView {
            
            //list by id
            List(userListViewModel.userList,id:\.id) { user in
                VStack {
                    Text(user.name)
                                        .font(.title3)
                                        .foregroundColor(.blue)
                                        .frame(maxWidth: .infinity, alignment:.leading)
                                    Text(user.username)
                                        .foregroundColor(.green)
                                        .frame(maxWidth: .infinity, alignment:.leading)
                                    Text(user.email)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment:.leading)
                }
            }.task {
                await userListViewModel.donwloadUsers()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
