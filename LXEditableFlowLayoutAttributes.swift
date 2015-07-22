//The MIT License (MIT)
//
//Copyright (c) 2015 Xuan
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

import Foundation

public class LXEditableFlowLayoutAttributes: UICollectionViewLayoutAttributes
{
    public var setDeleteButtonHidden: Bool
    
    override init() {
        setDeleteButtonHidden = true
        super.init()
    }
    
    /**
    while copying, we need to copy setDeleteButtonHidden as well
    
    :param: zone NSZone
    
    :returns: AnyObject
    */
    public override func copyWithZone(zone: NSZone) -> AnyObject
    {
        var attributes = super.copyWithZone(zone) as! LXEditableFlowLayoutAttributes
        attributes.setDeleteButtonHidden = setDeleteButtonHidden
        return attributes
    }
    
    /**
    This function is essential for the whole flow layout to work
    because UICollectionView will check if anything for the attributes has changed.
    If nothing changed, it will not trigger the flow layout to change at all
    
    In iOS 7, we must override isEqual: in your UICollectionViewLayoutAttributes subclass to compare any custom properties that you have.
    
    The default implementation of isEqual: does not compare your custom properties and thus always returns YES, which means that -applyLayoutAttributes: is never called.
    
    :param: object AnyObject?
    
    :returns: Bool
    */
    public override func isEqual(object: AnyObject?) -> Bool
    {
        var result = super.isEqual(object)
        if (result && object is LXEditableFlowLayoutAttributes)
        {
            var subResults = (self.setDeleteButtonHidden == (object as! LXEditableFlowLayoutAttributes).setDeleteButtonHidden)
            return result && subResults
        }
        return result
    }
}