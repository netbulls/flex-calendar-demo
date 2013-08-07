package com.flexcalendar.components.calendar.sample
{
public class ItemSetVO
{
	public var name:String;
	public var visible:Boolean;
	public var backgroundColor:Number;
	public var isNew:Boolean;
	public var deleted:Boolean;

	public function ItemSetVO(name:String,  visible:Boolean, backgroundColor:Number, isNew:Boolean, deleted:Boolean)
	{
		this.name = name;
		this.visible = visible;
		this.backgroundColor = backgroundColor;
		this.isNew = isNew;
		this.deleted = deleted;
	}
}
}
