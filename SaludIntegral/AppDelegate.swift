//
//  AppDelegate.swift
//  SaludIntegral
//
//  Created by Alumno on 07/03/18.
//  Copyright © 2018 SaludIntegral. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    var notificaciones: [Actividad] = []
    
    static var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = UIColor.blue  //Text
        navigationBarAppearance.barTintColor = UIColor.white //Bar color
    
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (allowed, error) in
            //
        }
        let reprogramarAction = UNNotificationAction(
            identifier: "reprogramar.action",
            title: "Ver Agenda",
            options: [.foreground])
        let okAction = UNNotificationAction(
            identifier: "ok.action",
            title: "OK",
            options: [.foreground])
        
        let reprogramarCategory = UNNotificationCategory(
            identifier: "reprogramar.category",
            actions: [reprogramarAction, okAction],
            intentIdentifiers: [],
            options: [])
        UNUserNotificationCenter.current().setNotificationCategories([reprogramarCategory])
        UNUserNotificationCenter.current().delegate = self
        
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        let dateFrom = calendar.startOfDay(for: Date())
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute],from: dateFrom)
        components.day! += 1
        let dateTo = calendar.date(from: components)!
        let fetchActividades = NSFetchRequest<NSFetchRequestResult>(entityName: "Actividad")
       fetchActividades.predicate = NSPredicate(format: "tipoFrecuencia == \(TipoFrecuencia.Uno.rawValue) AND (%@ <= fechaProgramada) AND (fechaProgramada < %@)", argumentArray: [dateFrom, dateTo])
        do {
            let actividades = try AppDelegate.context.fetch(fetchActividades) as! [Actividad]
            for actividad in actividades {
                agregarNotificacion(actividad: actividad)
            }
        } catch {
            print("Error: \(error)")
        }
        
        return true
    }
    
    
    func agregarNotificacion(actividad: Actividad) {
        if let alarma = actividad.alarma as Date? {
            let tomorrow = Date().tomorrow
            let yesterday = Date().yesterday
            let esProgramadoHoy =  actividad.tipoFrecuencia == TipoFrecuencia.Uno.rawValue  && (actividad.fechaProgramada! as Date) > yesterday && (actividad.fechaProgramada! as Date) < tomorrow
            let esSemanalHoy = actividad.tipoFrecuencia == TipoFrecuencia.Semanal.rawValue && actividad.frecuenciaSemana![Date().dayNumberOfWeek()-1]
            
            if (esSemanalHoy || esProgramadoHoy) {
                let content = UNMutableNotificationContent()
                content.title = actividad.titulo
                content.body = "Desliza para ir a agenda o quitar notificación"
                content.categoryIdentifier = "reprogramar.category"
                content.badge = 1
                let hour = Calendar.current.component(.hour, from: alarma)
                let minute = Calendar.current.component(.minute, from: alarma)
                let date = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date())
                
                let comps = Calendar.current.dateComponents( [.year, .month, .day, .hour, .minute, .second], from: date!)
                let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
                let request = UNNotificationRequest(identifier: "any", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "reprogramar.action" {
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //let vc = storyboard.instantiateViewController(withIdentifier: "Home")
            //let vcAgenda = storyboard.instantiateViewController(withIdentifier: "Agenda")
            //vc.navigationController?.pushViewController(vcAgenda, animated: true)
            var navigationController: UINavigationController? = (self.window?.rootViewController as? UINavigationController)
            
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            navigationController?.popToRootViewController(animated: false)
            navigationController?.pushViewController(storyboard.instantiateViewController(withIdentifier: "Agenda"), animated: false)
        } else if response.actionIdentifier == "ok.action" {
            
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "SaludIntegral")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if AppDelegate.context.hasChanges {
            do {
                try AppDelegate.context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }



}

