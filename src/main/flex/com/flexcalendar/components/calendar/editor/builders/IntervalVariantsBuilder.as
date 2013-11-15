package com.flexcalendar.components.calendar.editor.builders
{
import mx.collections.ArrayCollection;

public class IntervalVariantsBuilder
{
	public var intervalVariants:ArrayCollection;

	public function IntervalVariantsBuilder()
	{
		buildIntervalVariants();
	}

	public function buildIntervalVariants():void
	{
		var variants:ArrayCollection = new ArrayCollection();
		for(var i:int = 1; i <= 30; i++)
		{
			variants.addItem(buildVariant(i));
		}

		intervalVariants = variants;
	}

	private function buildVariant(i:int):Object
	{
		var obj:Object = new Object();
		obj.label = i + "";
		return obj; 
	}
}
}