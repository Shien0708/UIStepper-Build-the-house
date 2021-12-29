//
//  ViewController.swift
//  UIStepper
//
//  Created by 方仕賢 on 2021/12/28.
//

import UIKit

class ViewController: UIViewController {
    
    //連接各種元件成 IBOutlet
    @IBOutlet weak var selectedHouse: UISegmentedControl!
    
    @IBOutlet weak var totalFloors: UILabel!
    
    @IBOutlet weak var increaseStepper: UIStepper!
    
    @IBOutlet weak var decreaseStepper: UIStepper!
    
    @IBOutlet weak var apartmentPriceLabel: UILabel!
    
    @IBOutlet weak var templePriceLabel: UILabel!
    
    @IBOutlet weak var bigbenPriceLabel: UILabel!
    
    @IBOutlet weak var towerPriceLabel: UILabel!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var floorLabel: UILabel!
    
    
    @IBOutlet weak var apartmentCountLabel: UILabel!
    
    @IBOutlet weak var templeCountLabel: UILabel!
    
    @IBOutlet weak var bigbenCountLabel: UILabel!
    
    @IBOutlet weak var towerCountLabel: UILabel!
    
    
    // 宣告變數去儲存每種房子的價位，初始值為 0
    var apartmentPrice = 0
    
    var templePrice = 0
    
    var bigbenPrice = 0
    
    var towerPrice = 0
    
    var totalPrice = 0
    
    
    //宣告變數去儲存每種房子的個數，初始值為 0
    var apartmentCount = 0
    
    var templeCount = 0
    
    var bigbenCount = 0
    
    var towerCount = 0
    
    //宣告常數去儲存每種房子的結構圖片，分為 基地、樓層及屋頂的圖片
    let apartmentImage = ["base", "floor", "roof"]
    
    let templeImage = ["templeBase", "templeFloor", "templeRoof"]
    
    let bigbenImage = ["bigbenBase", "bigbenFloor", "bigbenRoof"]
    
    let towerImage = ["towerBase", "towerFloor", "towerRoof"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //宣告一個個往上加樓層的方法
    func build(base: String, floor: String, roof:String){
        
        /*宣告一個常數去儲存一個 ImageView，會根據黃色 stepper 的值去改變 y 值
         ，進而達到往上加疊的視覺效果*/
        let imageView = UIImageView(frame: CGRect(x: 127, y: 770 - increaseStepper.value * 80, width: 157.34, height: 80))
        
        /* 使用 if 條件句來決定要蓋的事房子的哪個結構。 如果黃色stepper 的值為1，則蓋的是基地。若值為 8(最大值），則蓋的是屋頂。 若為其他的值（中間值），則蓋樓層。 */
        if increaseStepper.value == 1 {
            
            imageView.image = UIImage(named: "\(base)")
            
        } else if increaseStepper.value == 8 {
            
            imageView.image = UIImage(named: "\(roof)")
            
        } else {
            
            imageView.image = UIImage(named: "\(floor)")
            
        }
        
        view.addSubview(imageView)
        
        // 若 stepper 值小於 1，總樓層label 的 Floor 字樣不加 s，否則就加。
        if increaseStepper.value <= 1 {
            floorLabel.text = "Floor"
        } else {
            floorLabel.text = "Floors"
        }
        
        //為了讓紅色 Stepper 的 "-" 可以起作用，要讓紅色 stepper 的值跟黃色 stepper 的值一樣，到時候才可以拆房子
        decreaseStepper.value = increaseStepper.value
        
    }
    
    //宣告一個拆房子的方法（往下加一個白色view)
    func debuild() {
        
        /* 宣告一個常數儲存一個 View。 根據紅色 Stepper 的值去改變 y 軸。這邊的值加 1 是因為按下紅色 Stepper 的 "-" 時，值會是0。
         必須加 1 讓 y軸跟剛剛蓋房子的值是一樣的。 */
        let whiteView = UIView(frame: CGRect(x: 127, y:770 - (decreaseStepper.value+1) * 80, width: 157.34, height: 80))
        
        //讓背景顏色為白色疊加在房子的 view 上，製造一種拆房的效果
        whiteView.backgroundColor = UIColor.white
        
        view.addSubview(whiteView)
        
        // 若 stepper 值小於 1，總樓層label 的 Floor 字樣不加 s，否則就加。
        if decreaseStepper.value <= 1 {
            floorLabel.text = "Floor"
        } else {
            floorLabel.text = "Floors"
        }
        
        //要讓黃色 stepper 的值減 1，才不會下一次蓋房子時還在剛剛的 y軸上蓋
        increaseStepper.value -= 1
        
    }
    
    //宣告一個刪除總樓層數量及總金額的方法
    func eraseTotal(value: Int) {
        
        totalFloors.text = "\(value)"
        
        totalPrice = apartmentPrice + templePrice + bigbenPrice + towerPrice
        
        totalPriceLabel.text = changeNumberStyle(num: totalPrice)
        
    }
    
    //宣告一個改變幣值為新台幣的方法，要傳入整數金額並回傳字串
    func changeNumberStyle(num: Int) -> String {
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        
        formatter.locale = Locale(identifier: "ch-TW")
        
        let moneyString = formatter.string(from: NSNumber(value: num))
        
        return moneyString!
    }
    
    
    //從黃色連線成 IBAction，宣告一個按 黃色stepper 後蓋房子及增加價位的方法
    @IBAction func buildTheHouse(_ sender: UIStepper) {
        
        let value = sender.value
        
        //取得 segmented Control 的值
        let houseIndex = selectedHouse.selectedSegmentIndex
        
        //用 segmented Control 的值來決定要蓋什麼房子
        if houseIndex == 0 {
            
            build(base: apartmentImage[0], floor: apartmentImage[1], roof: apartmentImage[2])
            
            apartmentPrice += 200
            
            apartmentPriceLabel.text = changeNumberStyle(num: apartmentPrice)
            
            apartmentCount += 1
            
            apartmentCountLabel.text = "\(apartmentCount)"

        } else if houseIndex == 1 {
            
            build(base: templeImage[0], floor: templeImage[1], roof: templeImage[2])
            
            templePrice += 300
            
            templePriceLabel.text = changeNumberStyle(num: templePrice)
            
            templeCount += 1
            
            templeCountLabel.text = "\(templeCount)"

            
        } else if houseIndex == 2 {
            
            build(base: bigbenImage[0], floor: bigbenImage[1], roof: bigbenImage[2])
            
            bigbenPrice += 400
            
            bigbenPriceLabel.text = changeNumberStyle(num: bigbenPrice)
            
            bigbenCount += 1
            
            bigbenCountLabel.text = "\(bigbenCount)"

            
        } else {
            
            build(base: towerImage[0], floor: towerImage[1], roof: towerImage[2])
            
            towerPrice += 500
            
            towerPriceLabel.text = changeNumberStyle(num: towerPrice)
            
            towerCount += 1
            
            towerCountLabel.text = "\(towerCount)"

        }
        
        //將黃色 stepper 的值當作總樓層的 label
        totalFloors.text = "\(Int(value))"
        
        totalPrice = apartmentPrice + templePrice + bigbenPrice + towerPrice
        
        totalPriceLabel.text = changeNumberStyle(num: totalPrice)
        
        
    }
    
    
    
    
    //從紅色 stepper 連線成 IBAction。宣告一個按紅色 stepper 後拆房子及減去金額的方法
    @IBAction func eraseTheHouse(_ sender: UIStepper) {
        
        
        let houseIndex = selectedHouse.selectedSegmentIndex
        
        //跟蓋房子的條件句大同小異，只是加變成減
        if houseIndex == 0 {
            
            /* 這邊要限制紅色 stepper 不能亂拆房子，至少該種建築要出現在畫面上才能拆除。
             使用 if 條件句檢查各種房子的數量使否大於 1，有才可以拆。*/
            if apartmentCount > 0 {
                
                debuild()
                
                apartmentPrice -= 200
                
                apartmentPriceLabel.text = changeNumberStyle(num: apartmentPrice)
                
                apartmentCount -= 1
                
                apartmentCountLabel.text = "\(apartmentCount)"
                
                eraseTotal(value: Int(increaseStepper.value))
                
            } else {
                
                /*雖然按一次紅色 stepper 會檢查一次，但按一次值就會被改變不管會不會拆，
                 所以當按一次stepper 時發現不會拆除的話，必須要再把stepper 的值加回來*/
                decreaseStepper.value += 1
                
            }
            
            
        } else if houseIndex == 1 {
            
            if templeCount > 0 {
                
                debuild()
                
                templePrice -= 300
                
                templePriceLabel.text = changeNumberStyle(num: templePrice)
                
                templeCount -= 1
                
                templeCountLabel.text = "\(templeCount)"
                
                eraseTotal(value: Int(increaseStepper.value))
                
            } else {
                
                decreaseStepper.value += 1
                
            }
            
         
        } else if houseIndex == 2 {
            
            if bigbenCount > 0 {
                
                debuild()
                
                bigbenPrice -= 400
                
                bigbenPriceLabel.text = changeNumberStyle(num: bigbenPrice)
                
                bigbenCount -= 1
                
                bigbenCountLabel.text = "\(bigbenCount)"
                
                eraseTotal(value: Int(increaseStepper.value))
                
            } else {
                
                decreaseStepper.value += 1
                
            }
            
        } else {
            
            if towerCount > 0 {
                
                debuild()
                
                towerPrice -= 500
                
                towerPriceLabel.text = changeNumberStyle(num: towerPrice)
                
                towerCount -= 1
                
                towerCountLabel.text = "\(towerCount)"
                
                eraseTotal(value: Int(increaseStepper.value))
                
            } else {
                
                decreaseStepper.value += 1
                
            }
            
        }
    }
    
    //從藍色 button 連線成 IBAction，宣告一個按一次按鈕即可刪除全部內容的方法
    @IBAction func clearAll(_ sender: UIButton) {
        
        /*當按下 clear button，要確定紅色stepper 是有值的，代表有房子要拆。
         如有房要拆，用for迴圈去確定要拆幾層樓才能拆完。*/
        if decreaseStepper.value > 0 {
            
            for _ in 0...Int(increaseStepper.value) {
                
                decreaseStepper.value -= 1
                
                debuild()
                
            }
        }
        
        //將所有的 值 跟 label 歸零
        increaseStepper.value = 0
        decreaseStepper.value = 0
        totalFloors.text = "0"
        
        apartmentPrice = 0
        templePrice = 0
        bigbenPrice = 0
        towerPrice = 0
        totalPrice = 0
        
        apartmentPriceLabel.text = changeNumberStyle(num: apartmentPrice)
        templePriceLabel.text = changeNumberStyle(num: templePrice)
        bigbenPriceLabel.text = changeNumberStyle(num: bigbenPrice)
        towerPriceLabel.text = changeNumberStyle(num: towerPrice)
        totalPriceLabel.text = changeNumberStyle(num: totalPrice)
        
        apartmentCount = 0
        templeCount = 0
        bigbenCount = 0
        towerCount = 0
        
        apartmentCountLabel.text = "0"
        templeCountLabel.text = "0"
        bigbenCountLabel.text = "0"
        towerCountLabel.text = "0"
    }
    

}

