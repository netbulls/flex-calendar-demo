package com.flexcalendar.components.calendar.editor.builders
{
import com.flexcalendar.components.calendar.core.dataModel.ICalendarDataProvider;

import mx.collections.ArrayCollection;

public class ItemSetVariantsBuilder
{
	public var itemSetVariants:ArrayCollection;
	private var _dataProvider:ICalendarDataProvider;

	public function ItemSetVariantsBuilder(dataProvider:ICalendarDataProvider)
	{
		_dataProvider = dataProvider;
		buildIntervalVariants();
	}

	public function buildIntervalVariants():void
	{
		var variants:ArrayCollection = new ArrayCollection();
		for(var i:int = 0; i < _dataProvider.getItemSetsCount(); i++)
		{
			variants.addItem(buildVariant(i));
		}

		itemSetVariants = variants;
	}

	private function buildVariant(i:int):Object
	{
		var obj:Object = new Object();
		obj.label = _dataProvider.getItemSetAt(i).name;
		return obj; 
	}
}
}