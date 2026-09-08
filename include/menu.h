#ifndef GUARD_MENU_H
#define GUARD_MENU_H

/* Cursor entries handled by Menu_ApplyCursorRoute. */
enum MenuCursorOption { MENU_CURSOR_FILE_SELECT = 0, MENU_CURSOR_OPTIONS = 1, MENU_CURSOR_MENU07 = 2 };

/* Values consumed by AgbMain from gIwram_3480.routerSelection. */
enum MenuRoute { MENU_ROUTE_FILE_SELECT = 1, MENU_ROUTE_OPTIONS = 2, MENU_ROUTE_MENU07 = 3, MENU_ROUTE_ATTRACT = 4 };

void Menu_ApplyCursorRoute(void);

#endif /* GUARD_MENU_H */
