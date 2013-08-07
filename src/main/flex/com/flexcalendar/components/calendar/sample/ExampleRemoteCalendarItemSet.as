package com.flexcalendar.components.calendar.sample
{
import com.flexcalendar.components.calendar.core.DateRange;
import com.flexcalendar.components.calendar.core.dataModel.BaseRemoteCalendarItemSet;
import com.flexcalendar.components.calendar.core.dataModel.CalendarItem;
import com.flexcalendar.components.calendar.core.dataModel.CalendarItemSet;
import com.flexcalendar.components.calendar.core.dataModel.IRemoteCalendarItemSet;
import com.flexcalendar.components.calendar.displayClasses.decoration.IRendererColors;
import com.flexcalendar.components.calendar.events.CalendarItemAddedEvent;
import com.flexcalendar.components.calendar.events.CalendarItemModificationEvent;
import com.flexcalendar.components.calendar.events.CalendarItemRemovedEvent;
import com.flexcalendar.components.calendar.events.GetEventsForDateRangeSuccessEvent;

import flash.utils.setTimeout;

import mx.controls.Alert;

public class ExampleRemoteCalendarItemSet extends BaseRemoteCalendarItemSet
{
	public function ExampleRemoteCalendarItemSet(readOnly:Boolean = false, name:String = null, itemSetColors:IRendererColors = null)
	{
		super(readOnly, name, itemSetColors);
	}

	override public function getEventsForDateRangeAsync(dateRange:DateRange, requestTimeStamp:Date):void
	{
		// inform component that background processing is taking place in this CalendarItemSet.
		backgroundProcessing = true;
		// change this to asynchronous remote calendar call
		var calendarItems:Array = getEventsForRequestedPeriod(dateRange);

		// simulate remote call processing
		setTimeout(simulateResponseHandler, 500, calendarItems, dateRange, requestTimeStamp);
	}

	private function simulateResponseHandler(calendarItems:Array, dateRange:DateRange, requestTimeStamp:Date):void
	{
		// when data is retrieved from remote calendar dispatch GetEventsForDateRangeSuccessEvent
		dispatchEvent(new GetEventsForDateRangeSuccessEvent(this, calendarItems, dateRange, requestTimeStamp));

		// inform component that background processing has finished.
		backgroundProcessing = false;
	}

	override public function onCalendarItemModified(event:CalendarItemModificationEvent):void
	{
		super.onCalendarItemModified(event);


//		Alert.show("Event has been modified. Save data to remote calendar.");

		// this change is already shown in calendar, you can always call:
		//		event.item.itemSet.parentCalendarComponent.refresh();
		// if you want to refresh entire calendar
	}

	override public function onCalendarItemAdded(event:CalendarItemAddedEvent):void
	{
		super.onCalendarItemAdded(event);

//		Alert.show("Event has been added. Save data to remote calendar.");

		// this change is already shown in calendar, you can always call:
		//		event.item.itemSet.parentCalendarComponent.refresh();
		// if you want to refresh entire calendar
	}

	override public function onCalendarItemRemoved(event:CalendarItemRemovedEvent):void
	{
		super.onCalendarItemRemoved(event);

//		Alert.show("Event has been removed. Delete data from remote calendar.");

		// this change is already shown in calendar, you can always call:
		//		event.item.itemSet.parentCalendarComponent.refresh();
		// if you want to refresh entire calendar
	}
}
}
