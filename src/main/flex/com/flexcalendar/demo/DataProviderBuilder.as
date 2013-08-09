package com.flexcalendar.demo
{
import com.flexcalendar.components.calendar.core.dataModel.CalendarDataProvider;
import com.flexcalendar.components.calendar.core.dataModel.CalendarItem;
import com.flexcalendar.components.calendar.core.dataModel.CalendarItemSet;
import com.flexcalendar.components.calendar.core.dataModel.ICalendarItem;
import com.flexcalendar.components.calendar.core.dataModel.ICalendarItemSet;
import com.flexcalendar.components.calendar.core.dataModel.ItemType;
import com.flexcalendar.components.calendar.core.dataModel.formatICalendar.Recur;
import com.flexcalendar.components.calendar.displayClasses.decoration.IRendererColors;
import com.flexcalendar.components.calendar.displayClasses.decoration.RendererColors;
import com.flexcalendar.components.calendar.displayClasses.decoration.RendererColorsFactory;
import com.flexcalendar.components.calendar.utils.DateOptions;
import com.flexcalendar.components.calendar.utils.DateUtils;

import mx.collections.ArrayCollection;

public class DataProviderBuilder
{

	public function DataProviderBuilder()
	{
	}

	public function populateHeavyLoad(itemSet:ICalendarItemSet, loadItems:Number):void
	{
		for (var i:int = 0; i < loadItems; i++)
		{
			itemSet.addItem(buildRandomItem());
		}
	}

	public function addHolidays(itemSet:ICalendarItemSet, exampleSet:int):void
	{
		switch (exampleSet)
		{
			case 0:
				itemSet.addItem(setItemAsReadonlySpace(buildItemWithDay(0, 0, 24, "Holiday", false,
						RendererColorsFactory.buildColors(RendererColors.GRAY)), ItemType.UNAVAILABLE_SPACE));
				itemSet.addItem(setItemAsReadonlySpace(buildItemWithDay(6, 0, 24, "Holiday", false,
						RendererColorsFactory.buildColors(RendererColors.GRAY)), ItemType.UNAVAILABLE_SPACE));
				break;
			case 1:
				itemSet.addItem(setItemAsReadonlySpace(buildItemWithDay(1, 0, 24, "Holiday", false,
						RendererColorsFactory.buildColors(RendererColors.GRAY)), ItemType.UNAVAILABLE_SPACE));
				itemSet.addItem(setItemAsReadonlySpace(buildItemWithDay(2, 0, 24, "Holiday", false,
						RendererColorsFactory.buildColors(RendererColors.GRAY)), ItemType.UNAVAILABLE_SPACE));
				break;
			case 2:
				itemSet.addItem(setItemAsReadonlySpace(buildItemWithDay(4, 0, 24, "Holiday", false,
						RendererColorsFactory.buildColors(RendererColors.GRAY)), ItemType.UNAVAILABLE_SPACE));
				break;
		}
	}

	private function setItemAsReadonlySpace(item:ICalendarItem, type:int):ICalendarItem
	{
		item.itemType = type;
		item.readOnly = true;
		return item;
	}

	public function removeHolidays(itemSet:ICalendarItemSet):void
	{
		var holidays:ArrayCollection = new ArrayCollection();

		for each (var calendarItem:ICalendarItem in itemSet.calendarItems)
		{
			if (calendarItem.itemType == ItemType.UNAVAILABLE_SPACE)
			{
				holidays.addItem(calendarItem);
			}
		}
		for each (var holiday:ICalendarItem in holidays)
		{
			itemSet.removeItem(holiday);
		}
		holidays.removeAll();
	}

	public function addWorkingHours(itemSet:ICalendarItemSet, exampeSet:int):void
	{
		switch (exampeSet)
		{
			case 0:
				itemSet.addItem(setItemAsReadonlySpace(buildItemWithDay(1, 8, 16, "Available", false,
						RendererColorsFactory.buildColors(RendererColors.WHITE)), ItemType.AVAILABLE_SPACE));
				itemSet.addItem(setItemAsReadonlySpace(buildItemWithDay(2, 14, 22, "Available", false,
						RendererColorsFactory.buildColors(RendererColors.WHITE)), ItemType.AVAILABLE_SPACE));
				itemSet.addItem(setItemAsReadonlySpace(buildItemWithDay(3, 8, 16, "Available", false,
						RendererColorsFactory.buildColors(RendererColors.WHITE)), ItemType.AVAILABLE_SPACE));
				itemSet.addItem(setItemAsReadonlySpace(buildItemWithDay(4, 14, 22, "Available", false,
						RendererColorsFactory.buildColors(RendererColors.WHITE)), ItemType.AVAILABLE_SPACE));
				itemSet.addItem(setItemAsReadonlySpace(buildItemWithDay(5, 8, 16, "Available", false,
						RendererColorsFactory.buildColors(RendererColors.WHITE)), ItemType.AVAILABLE_SPACE));
				break;
			case 1:
				itemSet.addItem(setItemAsReadonlySpace(buildItemWithDay(1, 14, 22, "Available", false,
						RendererColorsFactory.buildColors(RendererColors.WHITE)), ItemType.AVAILABLE_SPACE));
				itemSet.addItem(setItemAsReadonlySpace(buildItemWithDay(2, 8, 16, "Available", false,
						RendererColorsFactory.buildColors(RendererColors.WHITE)), ItemType.AVAILABLE_SPACE));
				itemSet.addItem(setItemAsReadonlySpace(buildItemWithDay(3, 14, 22, "Available", false,
						RendererColorsFactory.buildColors(RendererColors.WHITE)), ItemType.AVAILABLE_SPACE));
				itemSet.addItem(setItemAsReadonlySpace(buildItemWithDay(4, 8, 16, "Available", false,
						RendererColorsFactory.buildColors(RendererColors.WHITE)), ItemType.AVAILABLE_SPACE));
				itemSet.addItem(setItemAsReadonlySpace(buildItemWithDay(5, 14, 22, "Available", false,
						RendererColorsFactory.buildColors(RendererColors.WHITE)), ItemType.AVAILABLE_SPACE));
				break;
			case 2:
				itemSet.addItem(setItemAsReadonlySpace(buildItemWithDay(1, 18, 20, "Available", false,
						RendererColorsFactory.buildColors(RendererColors.WHITE)), ItemType.AVAILABLE_SPACE));
				itemSet.addItem(setItemAsReadonlySpace(buildItemWithDay(3, 18, 20, "Available", false,
						RendererColorsFactory.buildColors(RendererColors.WHITE)), ItemType.AVAILABLE_SPACE));
				itemSet.addItem(setItemAsReadonlySpace(buildItemWithDay(5, 10, 20, "Available", false,
						RendererColorsFactory.buildColors(RendererColors.WHITE)), ItemType.AVAILABLE_SPACE));
		}

	}

	public function removeWorkingHours(itemSet:ICalendarItemSet):void
	{
		var workingHours:ArrayCollection = new ArrayCollection();

		for each (var calendarItem:ICalendarItem in itemSet.calendarItems)
		{
			if (calendarItem.itemType == ItemType.AVAILABLE_SPACE)
			{
				workingHours.addItem(calendarItem);
			}
		}
		for each (var workingHour:CalendarItem in workingHours)
		{
			itemSet.removeItem(workingHour);
		}
		workingHours.removeAll();
	}

	public function buildExampleDataProvider():CalendarDataProvider
	{
		var builtDp:CalendarDataProvider = new CalendarDataProvider();

		var itemSet:CalendarItemSet = new ExampleRemoteCalendarItemSet();
		itemSet.name = "Remote Calendar";

		itemSet.addItem(buildItemWithDay(1, 8.5, 11, "Important meeting", false,
				RendererColorsFactory.buildColorsWithGradient(RendererColors.RED), "Custom tooltip"));
		itemSet.addItem(buildItemWithDay(1, 11.5, 12.5, "Lunch with Mark", false,
				RendererColorsFactory.buildColorsWithGradient(RendererColors.YELLOW)));

		itemSet.addItem(buildItemWithDay(2, 9.5, 12.5, "<b>Negotions</b> with <u>ABCD</u>", false,
				RendererColorsFactory.buildColorsWithGradient(RendererColors.LIGHT_BLUE)));

		itemSet.addItem(buildItemWithDay(3, 13, 16, "Busy", false,
				RendererColorsFactory.buildColorsWithGradient(RendererColors.VIOLET)));

		itemSet.addItem(buildItemWithDay(4, 8, 13, "Strategy planning", false,
				RendererColorsFactory.buildColorsWithGradient(RendererColors.ORANGE)));

		itemSet.addItem(buildItemWithDay(4, 14, 16, "Read only event", true));

		itemSet.addItem(buildItemWithDay(5, 10, 16, "Ecology meeting", false,
				RendererColorsFactory.buildColorsWithGradient(RendererColors.GREEN)));
		itemSet.addItem(buildItemWithDay(5, 18, 19, "Consultation", false,
				RendererColorsFactory.buildColorsWithGradient(RendererColors.BROWN)));

		itemSet.addItem(buildLongItem(1, 2, 0, 0, "I'm in Vancouver"));
		itemSet.addItem(buildLongItem(-3, 5, 0, 0, "Final Exams at St. Mary's"));

		builtDp.addItemSet(itemSet);

		itemSet = new CalendarItemSet();
		itemSet.name = "Laura's events(local)";
		itemSet.itemSetColors = RendererColorsFactory.buildColorsWithGradient(RendererColors.GREEN);
		itemSet.addItem(buildItemWithDay(4, 14, 16, "Read only event", false));

		builtDp.addItemSet(itemSet);

		var itemSet2:CalendarItemSet = new CalendarItemSet();
		itemSet2.name = "Dupa";
		builtDp.addItemSet(itemSet2);

		return builtDp;

	}

	private function buildItem(startTime:Number, endTime:Number, summary:String, readOnly:Boolean = false,
			rendererColors:IRendererColors = null):CalendarItem
	{
		var today:Date = DateUtils.startOfDay(new Date());
		var start:Date = new Date();
		start.time = today.time + startTime * DateUtils.MILLI_IN_HOUR;
		var end:Date = new Date();
		end.time = today.time + endTime * DateUtils.MILLI_IN_HOUR;
		return new CalendarItem(start, end, summary, null, readOnly, rendererColors);
	}


	private function buildItemWithDay(dayOffset:Number, startTime:Number, endTime:Number, summary:String,
			readOnly:Boolean = false, rendererColors:IRendererColors = null, tooltip:String = null):CalendarItem
	{
		var today:Date = DateUtils.startOfDay(new Date());
		var sunday:Date = DateUtils.startOfDay(new Date());
		DateUtils.addDays(sunday, 0 - today.day);
		DateUtils.addDays(sunday, dayOffset);
		var start:Date = new Date();
		start.time = sunday.time + startTime * DateUtils.MILLI_IN_HOUR;
		var end:Date = new Date();
		end.time = sunday.time + endTime * DateUtils.MILLI_IN_HOUR;
		return new CalendarItem(start, end, summary, null, readOnly, rendererColors, tooltip);
	}

	private function buildLongItem(dayOffset:Number, dayCount:int, startTime:Number, endTime:Number, summary:String):CalendarItem
	{
		var today:Date = DateUtils.startOfDay(new Date());
		var sunday:Date = DateUtils.startOfDay(new Date());
		DateUtils.addDays(sunday, 0 - today.day);
		DateUtils.addDays(sunday, dayOffset);
		var start:Date = new Date();
		start.time = sunday.time + startTime * DateUtils.MILLI_IN_HOUR;
		var end:Date = new Date();
		end.time = sunday.time + dayCount * DateUtils.MILLI_IN_DAY + endTime * DateUtils.MILLI_IN_HOUR;
		return new CalendarItem(start, end, summary);
	}

	private function buildRandomItem():CalendarItem
	{
		var startOfYear:Date = DateUtils.startOfYear(new Date());
		const hoursInTheYear:Number = 8760; //365 * 24 hours in the year
		var start:Date = new Date();
		start.time = startOfYear.time + DateUtils.MILLI_IN_HOUR * Math.ceil(Math.random() * hoursInTheYear);
		var end:Date = new Date();
		end.time = start.time + DateUtils.MILLI_IN_HOUR;

		return new CalendarItem(start, end, "High load");

	}

	public function testRecur():void
	{
		var defaultDateOptions:DateOptions = new DateOptions();

		var stringRecur:String = "";

		stringRecur = "FREQ=YEARLY";
		var recur1:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur1.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " + recur1.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=YEARLY;COUNT=3";
		var recur2:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur2.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " + recur2.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=YEARLY;COUNT=3;INTERVAL=6";
		var recur3:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur3.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " + recur3.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=YEARLY;COUNT=3;INTERVAL=6;BYSECOND=0,2,60";
		var recur4:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur4.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " + recur4.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=YEARLY;COUNT=3;INTERVAL=6;BYMINUTE=0,10,18,59";
		var recur5:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur5.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " + recur5.buildRecurString());

		stringRecur = "FREQ=YEARLY;COUNT=3;INTERVAL=6;BYHOUR=0,23";
		var recur6:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur6.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " + recur6.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=YEARLY;COUNT=3;INTERVAL=6;BYDAY=MO,SA";
		var recur7:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur7.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " + recur7.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=MONTHLY;COUNT=3;BYDAY=-1MO,2SA";
		var recur8:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur8.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " + recur8.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=YEARLY;BYMONTHDAY=1,25";
		var recur9:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur9.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " + recur9.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=YEARLY;BYMONTHDAY=-15,2,25";
		var recur10:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur10.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur10.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=YEARLY;BYYEARDAY=1,2,366";
		var recur11:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur11.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur11.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=YEARLY;BYYEARDAY=-366,-150,2,350";
		var recur12:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur12.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur12.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=YEARLY;BYWEEKNO=1,20,53";
		var recur13:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur13.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur13.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=YEARLY;BYWEEKNO=-53,-10,18";
		var recur14:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur14.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur14.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=YEARLY;BYMONTH=1,5,12";
		var recur15:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur15.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur15.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=SECONDLY";
		var recur16:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur16.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur16.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=MINUTELY;INTERVAL=2";
		var recur17:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur17.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur17.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=HOURLY;INTERVAL=1";
		var recur18:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur18.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur18.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=DAILY";
		var recur19:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur19.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur19.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=DAILY;COUNT=4";
		var recur20:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur20.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur20.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=WEEKLY";
		var recur21:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur21.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur21.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=MONTHLY";
		var recur22:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur22.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur22.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=YEARLY;INTERVAL=3";
		var recur23:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur23.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur23.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=MINUTELY;BYSECOND=1,2,3";
		var recur24:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur24.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur24.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=HOURLY;BYMINUTE=2,3,59";
		var recur25:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur25.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur25.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=DAILY;BYHOUR=10,11,12";
		var recur26:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur26.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur26.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=WEEKLY;BYDAY=MO,TU,FR";
		var recur27:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur27.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur27.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=MONTHLY;BYDAY=1MO";
		var recur28:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur28.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur28.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=MONTHLY;BYDAY=-1MO";
		var recur29:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur29.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur29.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=MONTHLY;BYMONTHDAY=1,5";
		var recur30:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur30.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur30.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=MONTHLY;BYMONTHDAY=-1";
		var recur31:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur31.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur31.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=YEARLY;BYYEARDAY=65";
		var recur32:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur32.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur32.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=YEARLY;BYYEARDAY=-10,-5";
		var recur33:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur33.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur33.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=DAILY;BYMONTH=2";
		var recur34:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur34.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur34.buildRecurString());
		else
			trace(stringRecur + " OK!");

		stringRecur = "FREQ=SECONDLY;BYMINUTE=2";
		var recur35:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur35.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur35.buildRecurString());
		else
			trace(stringRecur + " OK!");


		stringRecur = "FREQ=YEARLY;BYMONTH=10;BYDAY=-1SU;UNTIL=20061029T000000Z";
		var recur36:Recur = new Recur(stringRecur, defaultDateOptions);
		if (stringRecur != recur35.buildRecurString())
			trace("BuildRecurString returned wrong data. Expected: " + stringRecur + " , returned: " +
					recur36.buildRecurString());
		else
			trace(stringRecur + " OK!");


	}
}
}