// department_tab.dart
import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/features/library/domain/entities/department.dart';
import 'package:esl/features/library/domain/entities/library.dart';
import 'package:esl/features/library/presentation/blocs/resource_bloc.dart';
import 'package:esl/features/library/presentation/widgets/book_card.dart';
import 'package:esl/features/library/presentation/widgets/department_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DepartmentTab extends StatefulWidget {
  final List<Department> departments;

  const DepartmentTab({
    super.key,
    required this.departments,
  });

  @override
  State<DepartmentTab> createState() => _DepartmentTabState();
}

class _DepartmentTabState extends State<DepartmentTab> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ResourceBloc>().state;
    final isLoading = state is ResourceByDepartmentLoading || 
                     state is ResourceLoading;
                     
    final departments = isLoading
        ? List.generate(
            8,
            (_) => Department(
              id: '',
              departmentId: null,
              name: '',
              facultyId: '',
              imageUrl: '',
              resources: [],
            ),
          )
        : widget.departments;

    final resources = departments.isNotEmpty && _selectedIndex < departments.length
        ? departments[_selectedIndex].resources
        : <Library>[];

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ResourceBloc>().add(const RefreshLibraryData());
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: Skeletonizer(
        enabled: isLoading,
        child: ListView(
          children: [
            const Text('Department', style: boldTextStyle),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(departments.length, (index) {
                  final dept = departments[index];
                  final isSelected = index == _selectedIndex;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? AppConstants.eslGreen : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DepartmentCard(
                          image: AppConstants.engHorizontalGrey$GreyLOGO,
                          name: dept.name,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio:
                    MediaQuery.orientationOf(context) == Orientation.portrait
                        ? 0.8
                        : 1.8,
              ),
              itemCount: resources.length,
              itemBuilder: (context, index) {
                return BookCard(
                  title: resources[index].title,
                  downloadUrl: resources[index].documentUrl,
                  child: Image.asset(AppConstants.engHorizontalFullColor),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
