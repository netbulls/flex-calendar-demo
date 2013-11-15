package com.flexcalendar.components.calendar.editor.builders
{
import com.flexcalendar.components.calendar.editor.ItemEditorVO;

import mx.collections.ArrayCollection;
import mx.resources.IResourceManager;
import mx.resources.ResourceManager;

[ResourceBundle("FlexCalendar")]

public class RepeatVariantsBuilder
{
	public var repeatVariants:ArrayCollection;

	public function RepeatVariantsBuilder()
	{
		buildRepeatVariants();
	}

	public function buildRepeatVariants():void
	{
		//this builder has one limitation - variants are not updated when language chain changes...
		var resourceManager:IResourceManager = ResourceManager.getInstance();
		var variants:ArrayCollection = new ArrayCollection();
		variants.addItem(buildVariant(resourceManager.getString("FlexCalendar", "editor.variantDaily"), ItemEditorVO.DAILY));
		variants.addItem(buildVariant(resourceManager.getString("FlexCalendar", "editor.variantEveryWeekday"), ItemEditorVO.EVERY_WEEKDAY));
		variants.addItem(buildVariant(resourceManager.getString("FlexCalendar", "editor.variantMoWedFri"), ItemEditorVO.EVERY_MO_WED_FRI));
		variants.addItem(buildVariant(resourceManager.getString("FlexCalendar", "editor.variantTuesThurs"), ItemEditorVO.EVERY_THUES_THURS));
		variants.addItem(buildVariant(resourceManager.getString("FlexCalendar", "editor.variantWeekly"), ItemEditorVO.WEEKLY));
		variants.addItem(buildVariant(resourceManager.getString("FlexCalendar", "editor.variantMonthly"), ItemEditorVO.MONTHLY));
		variants.addItem(buildVariant(resourceManager.getString("FlexCalendar", "editor.variantYearly"), ItemEditorVO.YEARLY));

		repeatVariants = variants;
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