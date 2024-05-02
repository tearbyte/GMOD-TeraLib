TeraLib.lang = {}

local function GetCurLang()
	langs = {
		['Списки создаваемого'] = 'ru'
	}
	return langs[language.GetPhrase('spawnmenu.content_tab')] or 'en'
end

function TeraLib.lang.GetPhrase( phrase, lang )

	if language.GetPhrase(phrase) != phrase then return language.GetPhrase(phrase) end

	return TeraLib.lang[lang or TeraLib.lang.cur][phrase] or TeraLib.lang.en[phrase] or phrase
end

function TeraLib.lang.Add( lang, keyphrase, phrase )
	if !TeraLib.lang[lang] then
		TeraLib.lang[lang] = {}
	end

	TeraLib.lang[lang][keyphrase] = phrase
end

TeraLib.lang.cur = GetCurLang()

TeraLib.lang.en = {
	['TeraLib.poweredby'] = 'Powered by TeraLib',
	['TeraLib.download'] = 'Create your own addon with TeraLib!',
	['TeraLib.ClickToOpen'] = '<< Press one of the buttons on the left to select a page',
	['TeraLib.Settings'] = 'TeraLib control',
	['TeraLib.vgui'] = 'Appearance',
	['TeraLib.BaseColor'] = 'Background color',
	['TeraLib.SecondColor'] = 'Second background color',
	['TeraLib.ButtonColor'] = 'Button color',
	['TeraLib.HoverColor'] = 'Button hover color',
	['TeraLib.Fraction'] = 'Button animation color',
	['TeraLib.Selection'] = 'Active button color',
	['TeraLib.ScrollPanel'] = 'Scroll panel background',
	['TeraLib.ScrollHead'] = 'Scroll panel grip',
	['TeraLib.SaveColors'] = 'Apply colors',
	['TeraLib.BuiltInPresets'] = 'Built-In themes',
	['TeraLib.UserPresets'] = 'User themes',
	['TeraLib.LoadPreset'] = 'Load theme',
	['TeraLib.LoadPresetAndReset'] = 'Apply theme',
	['TeraLib.CheckBoxEnable'] = 'Enabled checkbox color',
	['TeraLib.CheckBoxDisable'] = 'Disabled checkbox color',
	['TeraLib.SavePreset'] = 'Save theme',
	['TeraLib.RemovePreset'] = 'Remove theme',
	['TeraLib.NewPreset'] = 'New theme',
	['TeraLib.InsertName'] = 'Insert name',
	['TeraLib.Create'] = 'Create',
	['TeraLib.About'] = 'About TeraLib',
	['TeraLib.Explanation'] = [[TeraLib is a library written by _Terabyte_ to speed up writing addons and unify some things,
	such as GUI and others. Also, the appearance of the interface of addons using TeraLib
	is designed to be unified and possible to change the color scheme
	(the so-called “themes”). 

	The panel below has a button, clicking on which will take you to the addon page, 
	where you can find methods for using library functions to write your future addons]],
	['reset'] = 'Reset',
	['noname'] = 'No Name',
}

TeraLib.lang.ru = {
	['TeraLib.poweredby'] = 'Создано с помощью TeraLib',
	['TeraLib.download'] = 'Создать свой аддон с TeraLib!',
	['TeraLib.ClickToOpen'] = '<< Нажмите на одну из клавиш слева для выбора страницы',
	['TeraLib.Settings'] = 'Управление TeraLib',
	['TeraLib.vgui'] = 'Внешний вид',
	['TeraLib.BaseColor'] = 'Цвет фона',
	['TeraLib.SecondColor'] = 'Доп цвет фона',
	['TeraLib.ButtonColor'] = 'Цвет кнопки',
	['TeraLib.HoverColor'] = 'Цвет при наведении',
	['TeraLib.Fraction'] = 'Цвет анимации загрузки',
	['TeraLib.Selection'] = 'Цвет активной кнопки',
	['TeraLib.ScrollPanel'] = 'Фон панели прокрутки',
	['TeraLib.ScrollHead'] = 'Цвет ручки прокрутки',
	['TeraLib.SaveColors'] = 'Применить цвет',
	['TeraLib.BuiltInPresets'] = 'Встроенные темы',
	['TeraLib.UserPresets'] = 'Пользовательские темы',
	['TeraLib.LoadPreset'] = 'Загрузить тему',
	['TeraLib.LoadPresetAndReset'] = 'Применить тему',
	['TeraLib.CheckBoxEnable'] = 'Цвет активного тумблера',
	['TeraLib.CheckBoxDisable'] = 'Цвет выключенного тумблера',
	['TeraLib.SavePreset'] = 'Сохранить тему',
	['TeraLib.RemovePreset'] = 'Удалить тему',
	['TeraLib.NewPreset'] = 'Создать тему',
	['TeraLib.InsertName'] = 'Введите название',
	['TeraLib.Create'] = 'Создать',
	['TeraLib.About'] = 'О TeraLib',
	['TeraLib.Explanation'] = [[TeraLib это библиотека, написанная _Terabyte_ для ускорения написания
	аддонов	и унификации некоторых вещей, таких как, к примеру, GUI,
	а также дать пользователям возможность самим выбирать цветовую
	схему окон (другими словами позволяет создавать темы). 

	На панели ниже имеется кнопка, нажав на которую, вы перейдёте
	на страницу, на которой будут описаны вещи для разработчиков,
	чтобы использовать функции библиотеки в ваших будущих аддонах]],
	['reset'] = 'Сброс',
	['noname'] = 'Без названия',
}