//
//  TaskDetailView.swift
//  TopdoList_Firebase_SwiftUI
//
//  Created by Syed Ghullam Meeran Gillani on 26/07/2022.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift


struct TaskDetailView: View{
     let task : Task
    @State private var title = ""
    let db: Firestore = Firestore.firestore()
    
    private func updateTask(){
        db.collection("tasks").document(task.id!).updateData(["title" : title])
    }
    var body: some View{
        VStack{
            TextField(task.title, text: $title)
                .textFieldStyle(.roundedBorder)
            Button {
                updateTask()
            } label: {
                Text("Update")
                    .foregroundColor(Color.blue)
            }

        }
    }
}
