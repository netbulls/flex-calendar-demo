package com.flexcalendar.components.calendar.editor.builders
{
import com.flexcalendar.components.calendar.core.dataModel.AlarmType;

import mx.collections.ArrayCollection;
import mx.resources.IResourceManager;
import mx.resources.ResourceManager;

public class AlarmVariantsBuilder
{
	public var alarmVariants:ArrayCollection;

	public function AlarmVariantsBuilder()
	{
		buildAlarmVariants();
	}

	public function buildAlarmVariants():void
	{
		//this builder has one limitation - variants are not updated when language chain changes...
		var resourceManager:IResourceManager = ResourceManager.getInstance();
		var variants:ArrayCollection = new ArrayCollection();
		variants.addItem(buildVariant("", -1));
		variants.addItem(buildVariant(resourceManager.getString("FlexCalendar", "editor.alarmMinute"), AlarmType.indexOf(new AlarmType(AlarmType.MINUTE))));
		variants.addItem(buildVariant(resourceManager.getString("FlexCalendar", "editor.alarmHour"), AlarmType.indexOf(new AlarmType(AlarmType.HOUR))));
		variants.addItem(buildVariant(resourceManager.getString("FlexCalendar", "editor.alarmDay"), AlarmType.indexOf(new AlarmType(AlarmType.DAY))));
		variants.addItem(buildVariant(resourceManager.getString("FlexCalendar", "editor.alarmWeek"), AlarmType.indexOf(new AlarmType(AlarmType.WEEK))));

		alarmVariants = variants;
	}

	private function buildVariant(name:String, value:int):Object
	{
		var obj:Object = new Object();
		obj.label = name;
		obj.value = value;

		return obj;
	}

}
}
