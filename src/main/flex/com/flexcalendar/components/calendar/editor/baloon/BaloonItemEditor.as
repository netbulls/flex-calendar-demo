package com.flexcalendar.components.calendar.editor.baloon
{
import com.flexcalendar.components.calendar.FlexCalendar;
import com.flexcalendar.components.calendar.core.dataModel.CalendarItem;
import com.flexcalendar.components.calendar.core.dataModel.ICalendarItem;
import com.flexcalendar.components.calendar.displayClasses.grids.DayViewGrid;
import com.flexcalendar.components.calendar.editor.IItemEditor;
import com.flexcalendar.components.calendar.editor.ItemEditorVO;
import com.flexcalendar.components.calendar.editor.ItemEditorVOConverter;
import com.flexcalendar.components.calendar.editor.builders.AlarmVariantsBuilder;
import com.flexcalendar.components.calendar.editor.builders.IntervalVariantsBuilder;
import com.flexcalendar.components.calendar.editor.builders.ItemSetVariantsBuilder;
import com.flexcalendar.components.calendar.editor.builders.RepeatVariantsBuilder;
import com.flexcalendar.components.calendar.events.CalendarDragEvent;
import com.flexcalendar.components.calendar.events.CalendarItemModificationEvent;
import com.flexcalendar.components.calendar.events.CalendarMouseBaseEvent;
import com.flexcalendar.components.calendar.events.CalendarMouseEvent;
import com.flexcalendar.components.calendar.utils.DateOptions;
import com.flexcalendar.components.calendar.utils.ItemDetails;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.geom.Point;

import mx.binding.utils.BindingUtils;
import mx.managers.PopUpManager;
import mx.resources.ResourceManager;

[ResourceBundle("FlexCalendar")]
/**
 * Baloon item editor interface.
 */

public class BaloonItemEditor implements IItemEditor
{
	private var isNew:Boolean = false;
	private var calendarItem:ICalendarItem;

	private var calendarMouseEvent:CalendarMouseBaseEvent;

	private var editorPanel:BaloonEditorPanel;
	private var calendar:FlexCalendar;

	private var converter:ItemEditorVOConverter;

	private var doubleClickOnRenderers:Boolean;
	private var doubleClickOnCalendar:Boolean;

	private var preferedTimeForNewEvents:Number;

	[Bindable]
	public var repetitionAvailable:Boolean = true;

	[Bindable]
	public var alarmsAvailable:Boolean = false;

	[Bindable]
	public var addressAvailable:Boolean = false;

	/**
	 * Editor constructor.
	 * @param calendar Flex Calendar instance
	 * @param doubleClickOnRenderers - false if editor should react for single click events on renderers, true for double click
	 * @param doubleClickOnCalendar - false if editor should react for single click events on calendar, true for double click
	 * @param repetitionAvailable - false if repetition editor should not be shown, default true
	 * @param alarmsAvailable - false if alarms editor should not be shown, default false
	 * @param addressAvailable - false if address editor should not be shown, default false
	 */
	public function BaloonItemEditor(calendar:FlexCalendar, doubleClickOnRenderers:Boolean = false,
			doubleClickOnCalendar:Boolean = false, repetitionAvailable:Boolean = true, alarmsAvailable:Boolean = false,
			addressAvailable:Boolean = false)
	{
		this.calendar = calendar;
		this.doubleClickOnRenderers = doubleClickOnRenderers;
		this.doubleClickOnCalendar = doubleClickOnCalendar;
		var dateOptions:DateOptions = new DateOptions();
		dateOptions.firstDayOfWeek = calendar.firstDayOfWeek;
		dateOptions.minDaysInFirstWeek = calendar.minDaysInFirstWeek;
		converter = new ItemEditorVOConverter(dateOptions);
		this.repetitionAvailable = repetitionAvailable;
		this.alarmsAvailable = alarmsAvailable;
		this.addressAvailable = addressAvailable;

	}

	public function calendarClickHandler(event:CalendarMouseEvent):void
	{
		if (!doubleClickOnCalendar)
			addNewItemPopup(event);
	}

	/**
	 * @inheritDoc
	 */
	public function calendarDoubleClickHandler(event:CalendarMouseEvent):void
	{
		if (doubleClickOnCalendar)
			addNewItemPopup(event);
	}

	private function addNewItemPopup(event:CalendarMouseEvent):void
	{
		calendarMouseEvent = event;
		preferedTimeForNewEvents = event.preferredTimeInMills;
		calendarItem = new CalendarItem(event.selectedDate, new Date(event.selectedDate.time + preferedTimeForNewEvents),
				ResourceManager.getInstance().getString("FlexCalendar", "editor.newItem"));
		calendarItem.itemSet = event.calendarItemSet;

		isNew = true;

		var calendarComponentMousePosition:Point = calendarMousePositionFromEvent(event);
		createEditorPopUp(calendarComponentMousePosition.x, calendarComponentMousePosition.y, saveCallbackForCreateHandler);
	}

	/**
	 * @inheritDoc
	 */
	public function rendererClickHandler(event:CalendarMouseEvent):void
	{
		if (!doubleClickOnRenderers)
			editItemPopup(event);
	}

	public function rendererDoubleClickHandler(event:CalendarMouseEvent):void
	{
		if (doubleClickOnRenderers)
			editItemPopup(event);
	}

	public function spaceRendererClickHandler(event:CalendarMouseEvent):void
	{
		if (!doubleClickOnRenderers)
		{
			addNewItemPopup(event);
		}

	}

	public function spaceRendererDoubleClickHandler(event:CalendarMouseEvent):void
	{
		if (doubleClickOnRenderers)
			addNewItemPopup(event);
	}

	public function dropHandler(event:CalendarDragEvent, calendarItem:ICalendarItem):void
	{
		calendarMouseEvent = event;
		preferedTimeForNewEvents = calendarItem.start.milliseconds;
		this.calendarItem = calendarItem;
		isNew = true;

		var calendarComponentMousePosition:Point = calendarMousePositionFromEvent(event);
		createEditorPopUp(calendarComponentMousePosition.x, calendarComponentMousePosition.y, saveCallbackForCreateHandler);
	}

	private function editItemPopup(event:CalendarMouseEvent):void
	{
		calendarMouseEvent = event;
		this.calendarItem = event.item;
		preferedTimeForNewEvents = event.preferredTimeInMills;
		isNew = false;

		var calendarComponentMousePosition:Point = calendarMousePositionFromEvent(event);
		createEditorPopUp(calendarComponentMousePosition.x, calendarComponentMousePosition.y, saveCallbackForUpdateHandler);
	}


	private function createEditorPopUp(clickedX:Number, clickedY:Number, saveCallback:Function):void
	{
		editorPanel = new BaloonEditorPanel();
		editorPanel.item = converter.calendarItemToItemEditorVO(calendarItem);
		editorPanel.saveCallback = saveCallback;
		editorPanel.cancelCallback = cancelCallbackHandler;
		editorPanel.deleteCallback = deleteCallback;
		editorPanel.repeatVariants = new RepeatVariantsBuilder().repeatVariants;
		editorPanel.intervalVariants = new IntervalVariantsBuilder().intervalVariants;
		editorPanel.alarmVariants = new AlarmVariantsBuilder().alarmVariants;
		editorPanel.itemSetVariants = new ItemSetVariantsBuilder(calendar.dataProvider).itemSetVariants;
		editorPanel.isNew = isNew;

		if (addressAvailable)
		{
			editorPanel.addressName = editorPanel.item.data.addressName;
			editorPanel.addressName = editorPanel.item.data.addressName;
			editorPanel.firstAddressLine = editorPanel.item.data.firstAddressLine;
			editorPanel.secondAddressLine = editorPanel.item.data.secondAddressLine;
			editorPanel.city = editorPanel.item.data.city;
			editorPanel.zip = editorPanel.item.data.zip;
			editorPanel.state = editorPanel.item.data.state;
		}


		BindingUtils.bindProperty(editorPanel, "repetitionAvailable", this, "repetitionAvailable");
		BindingUtils.bindProperty(editorPanel, "alarmsAvailable", this, "alarmsAvailable");
		BindingUtils.bindProperty(editorPanel, "addressAvailable", this, "addressAvailable");

		PopUpManager.addPopUp(editorPanel, calendar, true);

		editorPanel.calculatePosition(clickedX, clickedY);
	}

	/**
	 * Checks item range against space range and adjusts it if necessarry
	 */
	private function fixRange():void
	{
		if (calendarMouseEvent is CalendarMouseEvent)
		{
			var item:ICalendarItem = (calendarMouseEvent as CalendarMouseEvent).item;
			if (item != null && null != item.start && null != item.end)
			{
				if ((calendarItem.start < item.start) || (calendarItem.end <= item.start))
				{
					calendarItem.start = item.start;
					calendarItem.end = new Date(item.start.time + preferedTimeForNewEvents);
				}
				else if ((calendarItem.start >= item.end) || (calendarItem.end > item.end))
				{
					calendarItem.start = new Date(item.end.time - preferedTimeForNewEvents);
					calendarItem.end = item.end;
				}
			}
		}
	}

	private function saveCallbackForUpdateHandler():void
	{
		var item:ItemEditorVO = editorPanel.item;
		if ((null != calendarMouseEvent) && (null != calendarMouseEvent.renderersContainer))
		{
			var dayViewGrid:DayViewGrid = calendarMouseEvent.renderersContainer as DayViewGrid;
			if (null != dayViewGrid)
			{
				if (!dayViewGrid.isAvailableSpaceForGivenPeriod(item.start, item.end,
						calendar.dataProvider.getItemSetAt(item.itemSetIndex)))
				{
					// don't update if can't be placed in given place
					calendar.refresh();
					removeAndClosePopUp();
					return;
				}
			}
		}

		if (addressAvailable)
		{
			item.data.addressName = editorPanel.addressName;
			item.data.addressName = editorPanel.addressName;
			item.data.firstAddressLine = editorPanel.firstAddressLine;
			item.data.secondAddressLine = editorPanel.secondAddressLine;
			item.data.city = editorPanel.city;
			item.data.zip = editorPanel.zip;
			item.data.state = editorPanel.state;
		}

		calendarItem = converter.itemEditorVOToCalendarItem(item, calendarItem);

		if (calendar.dataProvider.getItemSetIndex(calendarItem.itemSet) != item.itemSetIndex)
		{
			calendarItem.itemSet.removeItem(calendarItem);
			calendar.dataProvider.getItemSetAt(item.itemSetIndex).addItem(calendarItem);
		}

		fixRange();
		calendar.updateItemDetails(new ItemDetails(calendarItem.itemSet, calendarItem));
		var modificationEvent:CalendarItemModificationEvent = new CalendarItemModificationEvent(CalendarItemModificationEvent.MODIFICATION_TYPE_ITEM_EDITED,
				calendarItem);
		calendar.dispatchEvent(modificationEvent);
		removeAndClosePopUp();
	}

	private function saveCallbackForCreateHandler():void
	{
		var item:ItemEditorVO = editorPanel.item;
		if ((null != calendarMouseEvent) && (null != calendarMouseEvent.renderersContainer))
		{
			var dayViewGrid:DayViewGrid = calendarMouseEvent.renderersContainer as DayViewGrid;
			if (null != dayViewGrid)
			{
				if (!dayViewGrid.isAvailableSpaceForGivenPeriod(item.start, item.end,
						calendar.dataProvider.getItemSetAt(item.itemSetIndex)))
				{
					// don't update if can't be placed in given place
					calendar.refresh();
					removeAndClosePopUp();
					return;
				}
			}
		}

		calendarItem = converter.itemEditorVOToCalendarItem(item, calendarItem);
		fixRange();
		calendar.dataProvider.getItemSetAt(item.itemSetIndex).addItem(calendarItem);
		calendar.updateItemDetails(new ItemDetails(calendarItem.itemSet, calendarItem));
		removeAndClosePopUp();
	}

	private function cancelCallbackHandler():void
	{
		removeAndClosePopUp();
	}

	private function deleteCallback():void
	{
		calendar.dataProvider.getItemSetAt(0).removeItem(calendarItem);
		calendar.deleteItemDetails(new ItemDetails(calendarItem.itemSet, calendarItem));
		removeAndClosePopUp();
	}

	private function removeAndClosePopUp():void
	{
		if (editorPanel)
		{
			PopUpManager.removePopUp(editorPanel);
			editorPanel = null;
			calendarMouseEvent = null;
		}
	}

	private function calendarMousePositionFromEvent(event:Event):Point
	{
		return calendar.globalToLocal((event.target as DisplayObject).localToGlobal(new Point(event.target.mouseX,
				event.target.mouseY)));
	}
}
}