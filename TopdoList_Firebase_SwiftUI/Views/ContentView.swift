//
//  ContentView.swift
//  TopdoList_Firebase_SwiftUI
//
//  Created by Syed Ghullam Meeran Gillani on 26/07/2022.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift




struct ContentView: View {
    
    
    
    private var db: Firestore
    @State private var title : String = ""
    @State private var tasks: [Task] = []
    
    init(){
        db = Firestore.firestore()
    }
    
    private func saveTask(task: Task){
        do{
            _ = try db.collection("tasks").addDocument(from: task){ err in
                
               if let error = err{
                    print(err?.localizedDescription)
               }else{
                   print("document has been saved!")
                   fetchAllTasks()
               }
            }
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func fetchAllTasks(){
        
        db.collection("tasks").getDocuments { (snapshot, error) in
            if let error = error{
                print(error.localizedDescription)
            }
            else{
                if let snapshot = snapshot{
                   tasks = snapshot.documents.compactMap{ doc in
                       var task = try? doc.data(as: Task.self)
                       if  task != nil {
                           task!.id = doc.documentID
                           print("task id")
                           print("\(task!.title) \( task!.id)")
                       }
//                        return try? doc.data(as: Task.self)
                       return task
                       
                    }
                }
            }
        }
    }
    
    private func deleteTask(at indexSet: IndexSet){
        indexSet.forEach { index in
            let task = tasks[index]
//            db.collection("tasks").document().id
            print("task id that will delete \(task.title) \(task.id)")
            db.document(task.id!)
                .delete { error in
                    if let error = error {
                        print(error.localizedDescription)
                    }else{
                        fetchAllTasks()
                    }
                }
        }
    }
    var body: some View {
        NavigationView{
        VStack{
            TextField("Enter Task", text: $title)
            Button {
                let task = Task(title: title)
                saveTask(task: task)
                
            } label: {
                Text("Save")
                    .foregroundColor(Color.blue)
                
            }
            List{
                
                ForEach(tasks,id:\.id){ task in
                    NavigationLink {
                        TaskDetailView(task: task)
                    } label: {
                        Text(task.title)
                    }

                        
                }
                .onDelete(perform: deleteTask)
            }

            Spacer()
                .onAppear(){
                    fetchAllTasks()
                }
        }.padding()
                .navigationTitle("Task")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
