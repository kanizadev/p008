import 'package:flutter/material.dart';
import 'examples/basic_widgets_example.dart';
import 'examples/navigation_example.dart';
import 'examples/form_example.dart';
import 'examples/list_example.dart';
import 'examples/animation_example.dart';
import 'examples/state_management_example.dart';
import 'examples/layout_example.dart';
import 'examples/dialog_example.dart';
import 'examples/advanced_animations_example.dart';
import 'examples/custom_widgets_example.dart';
import 'examples/advanced_layouts_example.dart';
import 'examples/advanced_navigation_example.dart';
import 'examples/performance_example.dart';
import 'examples/gestures_example.dart';
import 'examples/themes_styling_example.dart';
import 'examples/charts_graphs_example.dart';
import 'examples/drag_drop_example.dart';
import 'examples/accessibility_example.dart';
import 'examples/networking_example.dart';
import 'examples/local_storage_example.dart';
import 'examples/image_picker_example.dart';
import 'examples/responsive_design_example.dart';
import 'examples/pull_to_refresh_example.dart';
import 'examples/search_filter_example.dart';
import 'examples/file_operations_example.dart';
import 'examples/appbar_example.dart';
import 'examples/navigation_bar_example.dart';
import 'examples/drawer_example.dart';
import 'examples/tabbar_example.dart';
import 'examples/advanced_state_management_example.dart';
import 'examples/complex_animations_example.dart';
import 'examples/custom_painters_example.dart';
import 'examples/advanced_forms_example.dart';
import 'examples/advanced_list_example.dart';
import 'examples/parallax_scrolling_example.dart';
import 'examples/interactive_charts_example.dart';
import 'examples/stream_state_management_example.dart';

void main() {
  runApp(const ExamplesApp());
}

class ExamplesApp extends StatelessWidget {
  const ExamplesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Examples',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF87AE73), // Sage green
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF87AE73), // Sage green
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const ExamplesHomePage(),
    );
  }
}

class ExamplesHomePage extends StatefulWidget {
  const ExamplesHomePage({super.key});

  @override
  State<ExamplesHomePage> createState() => _ExamplesHomePageState();
}

class _ExamplesHomePageState extends State<ExamplesHomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  ExampleCategory? _selectedCategory;

  final List<ExampleItem> examples = const [
    ExampleItem(
      title: 'Basic Widgets',
      description: 'Text, Buttons, Icons, Images',
      icon: Icons.widgets,
      route: '/basic-widgets',
      category: ExampleCategory.basic,
    ),
    ExampleItem(
      title: 'Navigation',
      description: 'Routes, Navigation, Arguments',
      icon: Icons.navigation,
      route: '/navigation',
      category: ExampleCategory.basic,
    ),
    ExampleItem(
      title: 'Forms & Input',
      description: 'TextFields, Validation, Input Types',
      icon: Icons.text_fields,
      route: '/forms',
      category: ExampleCategory.basic,
    ),
    ExampleItem(
      title: 'Lists & Grids',
      description: 'ListView, GridView, ListTiles',
      icon: Icons.list,
      route: '/lists',
      category: ExampleCategory.basic,
    ),
    ExampleItem(
      title: 'Layouts',
      description: 'Row, Column, Stack, Container',
      icon: Icons.view_column,
      route: '/layouts',
      category: ExampleCategory.basic,
    ),
    ExampleItem(
      title: 'Animations',
      description: 'Transitions, Animations, Controllers',
      icon: Icons.animation,
      route: '/animations',
      category: ExampleCategory.basic,
    ),
    ExampleItem(
      title: 'State Management',
      description: 'setState, StatefulWidget patterns',
      icon: Icons.settings,
      route: '/state',
      category: ExampleCategory.basic,
    ),
    ExampleItem(
      title: 'Dialogs & Snackbars',
      description: 'AlertDialog, SnackBar, BottomSheet',
      icon: Icons.message,
      route: '/dialogs',
      category: ExampleCategory.basic,
    ),
    ExampleItem(
      title: 'Advanced Animations',
      description: 'Physics-based, Staggered, Complex animations',
      icon: Icons.science,
      route: '/advanced-animations',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Custom Widgets',
      description: 'Custom Paint, Canvas, Custom Renderers',
      icon: Icons.brush,
      route: '/custom-widgets',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Advanced Layouts',
      description: 'Slivers, CustomScrollView, NestedScrollView',
      icon: Icons.view_module,
      route: '/advanced-layouts',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Advanced Navigation',
      description: 'Nested routes, Deep linking, Custom transitions',
      icon: Icons.alt_route,
      route: '/advanced-navigation',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Performance',
      description: 'Optimization techniques, Build methods',
      icon: Icons.speed,
      route: '/performance',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Gestures',
      description: 'Tap, Drag, Pan, Scale, Long Press',
      icon: Icons.touch_app,
      route: '/gestures',
      category: ExampleCategory.basic,
    ),
    ExampleItem(
      title: 'Themes & Styling',
      description: 'Material 3, Colors, Text Styles',
      icon: Icons.palette,
      route: '/themes',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Charts & Graphs',
      description: 'Bar, Line, Pie charts, Progress rings',
      icon: Icons.bar_chart,
      route: '/charts',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Drag & Drop',
      description: 'Draggable, DropTarget, Reorderable',
      icon: Icons.swap_vert,
      route: '/drag-drop',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Accessibility',
      description: 'Semantics, Screen readers, A11y',
      icon: Icons.accessibility_new,
      route: '/accessibility',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Networking & API',
      description: 'HTTP requests, REST APIs, JSON',
      icon: Icons.cloud,
      route: '/networking',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Local Storage',
      description: 'SharedPreferences, Data persistence',
      icon: Icons.storage,
      route: '/storage',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Image Picker',
      description: 'Camera, Gallery, Image selection',
      icon: Icons.image,
      route: '/image-picker',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Responsive Design',
      description: 'MediaQuery, LayoutBuilder, Breakpoints',
      icon: Icons.devices,
      route: '/responsive',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Pull to Refresh',
      description: 'RefreshIndicator, Swipe to refresh',
      icon: Icons.refresh,
      route: '/pull-refresh',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Search & Filter',
      description: 'Real-time search, Filter chips',
      icon: Icons.search,
      route: '/search-filter',
      category: ExampleCategory.basic,
    ),
    ExampleItem(
      title: 'File Operations',
      description: 'Read, Write, Delete files',
      icon: Icons.insert_drive_file,
      route: '/file-ops',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'AppBar Variations',
      description: 'Different AppBar styles and configurations',
      icon: Icons.apps,
      route: '/appbar',
      category: ExampleCategory.basic,
    ),
    ExampleItem(
      title: 'Navigation Bars',
      description: 'Bottom Nav, Navigation Rail, Material 3',
      icon: Icons.navigation,
      route: '/navbar',
      category: ExampleCategory.basic,
    ),
    ExampleItem(
      title: 'Drawer',
      description: 'Standard, End, Custom drawer implementations',
      icon: Icons.menu,
      route: '/drawer',
      category: ExampleCategory.basic,
    ),
    ExampleItem(
      title: 'TabBar',
      description: 'TabBar, TabBarView, Scrollable tabs',
      icon: Icons.tab,
      route: '/tabbar',
      category: ExampleCategory.basic,
    ),
    ExampleItem(
      title: 'Advanced State Management',
      description: 'ValueNotifier, ChangeNotifier, Composed state',
      icon: Icons.data_object,
      route: '/advanced-state',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Complex Animations',
      description: 'Multi-stage, curves, transforms, paths',
      icon: Icons.animation,
      route: '/complex-animations',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Custom Painters',
      description: 'Canvas API, custom graphics, particle systems',
      icon: Icons.brush,
      route: '/custom-painters',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Advanced Forms',
      description: 'Multi-step forms, dynamic fields, validation',
      icon: Icons.article,
      route: '/advanced-forms',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Advanced Lists',
      description: 'Pagination, infinite scroll, filtering, sorting',
      icon: Icons.list_alt,
      route: '/advanced-lists',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Parallax Scrolling',
      description: 'Parallax headers, nested scrolls, sticky headers',
      icon: Icons.view_carousel,
      route: '/parallax-scrolling',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Interactive Charts',
      description: 'Touch interactions, animations, real-time updates',
      icon: Icons.bar_chart,
      route: '/interactive-charts',
      category: ExampleCategory.advanced,
    ),
    ExampleItem(
      title: 'Stream State Management',
      description: 'StreamController, StreamBuilder, real-time updates',
      icon: Icons.stream,
      route: '/stream-state',
      category: ExampleCategory.advanced,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ExampleItem> get _filteredExamples {
    return examples.where((example) {
      final matchesSearch =
          example.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          example.description.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      final matchesCategory =
          _selectedCategory == null || example.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final basicExamples = _filteredExamples
        .where((e) => e.category == ExampleCategory.basic)
        .toList();
    final advancedExamples = _filteredExamples
        .where((e) => e.category == ExampleCategory.advanced)
        .toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Flutter Examples',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _selectedCategory == null
                  ? Icons.filter_list
                  : Icons.filter_list_off,
            ),
            onPressed: () {
              setState(() {
                _selectedCategory = _selectedCategory == null
                    ? ExampleCategory.basic
                    : null;
              });
            },
            tooltip: 'Filter',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search examples...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Category Chips
          if (_selectedCategory == null)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildCategoryChip('All', null),
                    _buildCategoryChip('Basic', ExampleCategory.basic),
                    _buildCategoryChip('Advanced', ExampleCategory.advanced),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 8),

          // Examples List
          Expanded(
            child: _filteredExamples.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primaryContainer
                                    .withValues(alpha: 0.3),
                                Theme.of(context).colorScheme.primaryContainer
                                    .withValues(alpha: 0.1),
                              ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.search_off,
                            size: 64,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'No examples found',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your search or filters',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemBuilder: (context, index) {
                      if (_selectedCategory == null) {
                        // Build sections with headers when no filter
                        if (basicExamples.isNotEmpty &&
                            advancedExamples.isNotEmpty) {
                          // Two sections
                          if (index == 0) {
                            return _buildSectionHeader('Basic Examples');
                          } else if (index <= basicExamples.length) {
                            return _buildExampleCard(
                              context,
                              basicExamples[index - 1],
                            );
                          } else if (index == basicExamples.length + 1) {
                            return _buildSectionHeader('Advanced Examples');
                          } else {
                            final advancedIndex =
                                index - basicExamples.length - 2;
                            if (advancedIndex < advancedExamples.length) {
                              return _buildExampleCard(
                                context,
                                advancedExamples[advancedIndex],
                              );
                            }
                          }
                        } else if (basicExamples.isNotEmpty) {
                          // Only basic examples
                          if (index == 0) {
                            return _buildSectionHeader('Basic Examples');
                          } else if (index <= basicExamples.length) {
                            return _buildExampleCard(
                              context,
                              basicExamples[index - 1],
                            );
                          }
                        } else if (advancedExamples.isNotEmpty) {
                          // Only advanced examples
                          if (index == 0) {
                            return _buildSectionHeader('Advanced Examples');
                          } else if (index <= advancedExamples.length) {
                            return _buildExampleCard(
                              context,
                              advancedExamples[index - 1],
                            );
                          }
                        }
                      } else {
                        // Category filter is active - show items directly without headers
                        if (index < _filteredExamples.length) {
                          return _buildExampleCard(
                            context,
                            _filteredExamples[index],
                          );
                        }
                      }

                      return const SizedBox.shrink();
                    },
                    itemCount: _selectedCategory == null
                        ? _filteredExamples.length +
                              (basicExamples.isNotEmpty &&
                                      advancedExamples.isNotEmpty
                                  ? 2
                                  : basicExamples.isNotEmpty ||
                                        advancedExamples.isNotEmpty
                                  ? 1
                                  : 0)
                        : _filteredExamples.length,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, ExampleCategory? category) {
    final isSelected = _selectedCategory == category;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Theme.of(context).colorScheme.onPrimary : null,
          ),
        ),
        selected: isSelected,
        selectedColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        checkmarkColor: Colors.white,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = selected ? category : null;
          });
        },
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(
              context,
            ).colorScheme.primaryContainer.withValues(alpha: 0.5),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleCard(BuildContext context, ExampleItem example) {
    final isAdvanced = example.category == ExampleCategory.advanced;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.surfaceContainerHighest,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.08),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _navigateToExample(context, example.route),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isAdvanced
                          ? [Colors.orange, Colors.deepOrange]
                          : [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.tertiary,
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color:
                            (isAdvanced
                                    ? Colors.orange
                                    : Theme.of(context).colorScheme.primary)
                                .withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(example.icon, color: Colors.white, size: 32),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              example.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Theme.of(context).colorScheme.onSurface,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isAdvanced
                                    ? [
                                        Colors.orange.withValues(alpha: 0.2),
                                        Colors.deepOrange.withValues(
                                          alpha: 0.15,
                                        ),
                                      ]
                                    : [
                                        Theme.of(
                                          context,
                                        ).colorScheme.primaryContainer,
                                        Theme.of(context)
                                            .colorScheme
                                            .primaryContainer
                                            .withValues(alpha: 0.7),
                                      ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isAdvanced
                                    ? Colors.orange.withValues(alpha: 0.3)
                                    : Theme.of(context).colorScheme.primary
                                          .withValues(alpha: 0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              isAdvanced ? 'ADVANCED' : 'BASIC',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: isAdvanced
                                    ? Colors.orange[900]
                                    : Theme.of(context).colorScheme.primary,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        example.description,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.primary,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToExample(BuildContext context, String route) {
    switch (route) {
      case '/basic-widgets':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BasicWidgetsExample()),
        );
        break;
      case '/navigation':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NavigationExample()),
        );
        break;
      case '/forms':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FormExample()),
        );
        break;
      case '/lists':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ListExample()),
        );
        break;
      case '/layouts':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LayoutExample()),
        );
        break;
      case '/animations':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AnimationExample()),
        );
        break;
      case '/state':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const StateManagementExample()),
        );
        break;
      case '/dialogs':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DialogExample()),
        );
        break;
      case '/advanced-animations':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AdvancedAnimationsExample()),
        );
        break;
      case '/custom-widgets':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CustomWidgetsExample()),
        );
        break;
      case '/advanced-layouts':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AdvancedLayoutsExample()),
        );
        break;
      case '/advanced-navigation':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AdvancedNavigationExample()),
        );
        break;
      case '/performance':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PerformanceExample()),
        );
        break;
      case '/gestures':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const GesturesExample()),
        );
        break;
      case '/themes':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ThemesStylingExample()),
        );
        break;
      case '/charts':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ChartsGraphsExample()),
        );
        break;
      case '/drag-drop':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DragDropExample()),
        );
        break;
      case '/accessibility':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AccessibilityExample()),
        );
        break;
      case '/networking':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NetworkingExample()),
        );
        break;
      case '/storage':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LocalStorageExample()),
        );
        break;
      case '/image-picker':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ImagePickerExample()),
        );
        break;
      case '/responsive':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ResponsiveDesignExample()),
        );
        break;
      case '/pull-refresh':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PullToRefreshExample()),
        );
        break;
      case '/search-filter':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SearchFilterExample()),
        );
        break;
      case '/file-ops':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FileOperationsExample()),
        );
        break;
      case '/appbar':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AppBarExample()),
        );
        break;
      case '/navbar':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NavigationBarExample()),
        );
        break;
      case '/drawer':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DrawerExample()),
        );
        break;
      case '/tabbar':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TabBarExample()),
        );
        break;
      case '/advanced-state':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AdvancedStateManagementExample(),
          ),
        );
        break;
      case '/complex-animations':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ComplexAnimationsExample()),
        );
        break;
      case '/custom-painters':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CustomPaintersExample()),
        );
        break;
      case '/advanced-forms':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AdvancedFormsExample()),
        );
        break;
      case '/advanced-lists':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AdvancedListExample()),
        );
        break;
      case '/parallax-scrolling':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ParallaxScrollingExample()),
        );
        break;
      case '/interactive-charts':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const InteractiveChartsExample()),
        );
        break;
      case '/stream-state':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const StreamStateManagementExample(),
          ),
        );
        break;
    }
  }
}

enum ExampleCategory { basic, advanced }

class ExampleItem {
  final String title;
  final String description;
  final IconData icon;
  final String route;
  final ExampleCategory category;

  const ExampleItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
    this.category = ExampleCategory.basic,
  });
}
