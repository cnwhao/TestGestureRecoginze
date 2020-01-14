# IOS开发--手势识别 Gesture Recognize

标签（空格分隔）： IOS

---

回顾IOS开发中的知识点，如有引用未注明出处，望告知；如有理解有错误的地方，望指正。感谢！！！

---

Demo：[https://github.com/cnwhao/TestGestureRecoginze.git](https://github.com/cnwhao/TestGestureRecoginze.git)

---

- [x] 手势识别 Gesture Recognize
- [x] UIGestureRecognizer六大子类使用demo

---
  

如果想监听一个UIView上的单击事件，可以通过下面两种方式。

 1. 自定义UIView，然后重写touches方法。  
    
    繁琐：
    * 需要自定义UIView。
    * 自定义UIView内部的touches方法需要额外设置代理才能在外部监听。
    * 通过触摸事件的监听推断出手势类型十分复杂。

 2. iOS3.2之后，使用手势识别功能（Gesture Recognizer）
```Swift
extension UIView {

    @available(iOS 3.2, *)
    open var gestureRecognizers: [UIGestureRecognizer]?

    @available(iOS 3.2, *)
    open func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer)

    @available(iOS 3.2, *)
    open func removeGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer)

    @available(iOS 6.0, *)
    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool
}
```

---

所以可以看出来手势识别是对事件处理的封装，简化了触摸事件处理的开发难度。

---

## 手势识别和事件响应混用

触摸事件可以通过响应链来传递与处理，也可以被绑定在view上的手势识别和处理。

- 触摸事件首先传递到手势上，如果手势识别成功，就会取消事件的继续传递，否则，事件还是会被响应链处理。 
- 系统维持了与响应链关联的所有手势，事件首先发给这些手势，然后再发给响应链。（手势对事件处理具有更高优先级）

---

## 手势识别器 UIGestureRecognizer
UIGestureRecognizer是一个抽象类，定义了所有手势的基本行为，它的子类实现了具体的手势处理。

**手势状态**
```Swift
typedef NS_ENUM(NSInteger, UIGestureRecognizerState) {
    // 没有触摸事件发生，所有手势识别的默认状态
    UIGestureRecognizerStatePossible,
    // 一个手势已经开始但尚未改变或者完成时
    UIGestureRecognizerStateBegan,
    // 手势状态改变
    UIGestureRecognizerStateChanged,
    // 手势完成
    UIGestureRecognizerStateEnded,
    // 手势取消，恢复至Possible状态
    UIGestureRecognizerStateCancelled, 
    // 手势失败，恢复至Possible状态
    UIGestureRecognizerStateFailed,
    // 识别到手势识别
    UIGestureRecognizerStateRecognized,
};
```

**UIGestureRecognizer实现子类**

- UITapGestureRecognizer        敲击
- UIPinchGestureRecognizer      捏合，用于缩放
- UIPanGestureRecognizer        拖拽
- UISwipeGestureRecognizer      轻扫
- UIRotationGestureRecognizer   旋转
- UILongPressGestureRecognizer  长按  

       
**UIGestureRecognizer 定义了三个属性，能够影响hit-test view触摸事件的调用过程。**
> 1、open var cancelsTouchesInView: Bool // default is YES
>> 表示手势识别成功后触摸事件取消掉，即识别成功后hitTest-View会调用touchesCancelled函数。 

> 2、open var delaysTouchesBegan: Bool // default is NO.  
>> 触摸事件和手势识别的过程同时进行，先会发送触摸事件，然后当手势识别成功时，触摸事件会被取消掉，即识别成功后hitTest-View会调用touchesCancelled函数。
>  
>> 当值为YES时，手势识别器先接收touch事件进行手势识别，识别过程中hit-test view的触摸事件会先被UIWindow hold住，当手势识别成功时hit-test view的触摸事件不会调用，当手势识别失败时才开始调用touchesBegan函数 。  
>
> 3、open var delaysTouchesEnded: Bool // default is YES.
>
>> 当值为YES时（默认值），当手势识别失败时会延迟（约0.15ms）调用touchesEnded函数。
当值为NO时，当手势识别失败时会立即调用touchesEnded函数。
>  
> 总结：  
1、cancelsTouchesInView为ture，如果手势识别成功，则触摸事件touches begin/end 会被调用。  
2、cancelsTouchesInView为false，如果手势识别成功，则触摸事件touches begin/cancel 会被调用。  
3、delaysTouchesBegan为true，如果手势识别成功，则触摸事件touches begin/cancle/end 都不会被调用。    
4、一般来说手势识别器的回调函数会比hit-test view的触摸事件的晚一些（因为手势识别器只有在手势识别出来之后才会触发回调函数），通过上面三个属性的组合，使的手势识别器对事件的处理优先级更高。
>

**UIGestureRecognizer 注意的方法**
> open func require(toFail otherGestureRecognizer: UIGestureRecognizer)
>> 指定一个手势需要另一个手势执行失败才会执行
>> 场景：同时触发多个手势使用其中一个手势的

---

## UIGestureRecognizerDelegate

```Swift
public protocol UIGestureRecognizerDelegate : NSObjectProtocol {
    // 返回NO则结束识别，不再触发手势，用处：可以在控件指定的位置使用手势识别
    @available(iOS 3.2, *)
    optional func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool

    // 是否支持多手势触发
    @available(iOS 3.2, *)
    optional func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool

    // 返回YES，第一个手势和第二个互斥时，**第一个会失效**
    @available(iOS 7.0, *)
    optional func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool
    
    // 返回YES，第一个和第二个互斥时，**第二个会失效**
    @available(iOS 7.0, *)
    optional func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool

    
    // 调用gesture recognizer的touchesBegan:withEvent:方法之前调用，手指触摸屏幕后回调的方法，返回NO则不再进行手势识别
    @available(iOS 3.2, *)
    optional func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool

    // 调用gesture recognizer的pressesBegan:withEvent:方法之前调用，手指按压屏幕后回调的方法，返回NO则不再进行手势识别
    @available(iOS 9.0, *)
    optional func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool
}
```

---
