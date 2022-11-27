//
//  Persistance.swift
//  Lesson 14 path 2
//
//  Created by Илья Богданов on 17.10.2022.
//

import Foundation
import RealmSwift
//Object означает, что объект является реалмовским (Realm)
//ключи @objc и dymanic позволяют Realm'у работать со свойствами (реагировать и записывать в свойства нужные значения)

class Human: Object{
    @objc dynamic var name = ""
    let dogs = List<Dog>()
}

class Dog: Object{
    @objc dynamic var name = ""
    //перед внесением нового поля необходимо выполнить миграцию при разработке можно просто удалить старое приложение
    @objc dynamic var age = 0
    @objc dynamic var owner: Human?
}

class Garbage: Object{
    @objc dynamic var name = ""
}

class Persistance{
    static let shared = Persistance()
    
    //ссылка на объект Realm:
    private let realm = try! Realm()
    
    func test(){
        
        let human1 = Human()
        human1.name = "Nikita"
//        human1.dogs.append(Dog())
//        human1.dogs.remove(at: 0)
        
        let dog1 = Dog()
        dog1.name = "Marta"
        dog1.owner = human1
        human1.dogs.append(dog1)
        let dog2 = Dog()
        dog2.name = "Sheila"
        dog2.owner = human1
        let dog3 = Dog()
        dog3.name = "Jacob"
        let dog4 = Dog()
        dog4.name = "Sharick"
        dog4.owner = Human()
        try! realm.write{
            realm.add(human1)
            realm.add(dog1)
            realm.add(dog2)
            realm.add(dog3)
            realm.add(dog4)
        }
        
                for dogs in realm.objects(Dog.self){
                    //можно напрямую из реалма for dog in realm.objects(Dog.self)
                    var owner = dogs.owner?.name ?? "no one"
                    if owner == "" {owner = "name is unknown"}
                    print("--\(dogs.name)'s owner is \(owner)")
                }
                for humans in realm.objects(Human.self){
                    //можно напрямую из реалма for dog in realm.objects(Dog.self)
                    var human = humans.name
                    if human == ""{
                        human = "name is unknown"
                    }
                    print("\(human)'s dogs are listed below:")
                    for dogs in humans.dogs{
                        var dog = dogs.name
                        if dog == "" {dog = "dog has no name"}
                        print(dogs.name)
                    }
                }
//        try! realm.write {
//        let garbage = Garbage()
//        garbage.name = "Just garbage"
//        realm.add(garbage)
//        }
//        dog.age = 4
//        //то что мы написали dog.name = "Marta" не означает, что это сразу попало в базу. Для сохранения в базу надо сделать следующее:
//        realm.add(dog)
//
//        let dog2 = Dog()
//        dog2.name = "Jacobs"
//        dog2.age = 2
//        realm.add(dog2)
//
//        let dog3 = Dog()
//        dog3.name = "Sheila"
//        dog3.age = 6
//        realm.add(dog3)
//        }
        //может отфильтровать всех собак с возрастом более 3 лет: let allDogs = realm.objects(Dog.self).filter("age > 3")
//        let allGarbage = realm.objects(Garbage.self)

        //изменить имена всех собак:
//        try! realm.write {
//            for (index, dog) in allDogs.enumerated(){
//                dog.age = index * 2 + 2
//            }
//        }
//        удаление первого объекта:
//        let garbage = realm.objects(Garbage.self).first!
//        try! realm.write {
//            realm.delete(garbage)
//        }

        //получить всех собак:
        //command + control + E - редактировать имя во всех местах где оно используется
//        for g in realm.objects(Garbage.self){
//            //можно напрямую из реалма for dog in realm.objects(Dog.self)
//            print("--\(g.name)")
//        }
    }
}
