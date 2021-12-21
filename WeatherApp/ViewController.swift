//
//  ViewController.swift
//  WeatherApp
//
//  Created by Maha saad on 17/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityname: UILabel!
    
    @IBOutlet weak var main: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var mainTemp: UILabel!
    
    @IBOutlet weak var weatherDis: UILabel!
    
    var weatherInfo : Welcome?
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

    let url = URL(string:"http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=8e81f249a02ae4001c9cf723c597e65a")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url! , completionHandler : {
            data, response, error in
            print("in here")
            print(data ?? "no data")
            
            guard let myData = data else {return}
            do{
              //  if let jsonResult = try JSONSerialization.jsonObject(with: myData, options:JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
                //    print(jsonResult)
                 //   for re in jsonResult {
                 //     let object = re as! NSDictionary
                 //     guard let w = object["weather"] as? String else {return}
                    //self.weather?.append(name)
                  //      self.mm?.append(w)
                       
                
                //    }}
                
                let welcome = try JSONDecoder().decode(Welcome.self, from: myData)
                 self.weatherInfo = welcome
                
                let more = welcome.weather
                
                print(more[0].weatherDescription)

                DispatchQueue.main.async {
                    
                    self.cityname.text = "\(self.weatherInfo?.name ?? "" ) " + "\(self.weatherInfo?.sys.country ?? "" ) Weather "
                    self.main.text = "\(more[0].weatherDescription)"

                    self.weatherDis.text = "\(more[0].main) "
                    self.mainTemp.text = " \(Int(self.weatherInfo?.main.temp ?? 0.0)) K "

                    self.temp.text = "Max: \(Int(self.weatherInfo?.main.tempMax ?? 0.0 )) K    Min: \(Int(self.weatherInfo?.main.tempMin ?? 0.0 )) K "
                    
                    self.details.text = "wind speed :\(self.weatherInfo?.wind.speed ?? 0.0)\nhumidity : \(self.weatherInfo?.main.humidity ?? 0 ) \nfeelsLike: \(self.weatherInfo?.main.feelsLike ?? 0)  \npressure: \(self.weatherInfo?.main.pressure ?? 0 ) "
                }
    
            }catch{
                print(error.localizedDescription)
            }
        })
       
        task.resume()

    }
}

