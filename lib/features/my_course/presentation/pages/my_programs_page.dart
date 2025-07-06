import 'package:esl/core/loaders/loading_widget.dart';
import 'package:esl/features/my_course/presentation/blocs/my_course/my_course_bloc.dart';
import 'package:esl/features/my_course/presentation/widgets/program_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyProgramsPage extends StatefulWidget {
  const MyProgramsPage({super.key});

  @override
  State<MyProgramsPage> createState() => _MyProgramsPageState();
}

class _MyProgramsPageState extends State<MyProgramsPage> 
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  @override
  bool get wantKeepAlive => true;

  bool _hasInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadPrograms();
    _hasInitialized = true;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasInitialized) {
      _loadPrograms();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _refreshPrograms();
    }
  }

  @override
  void didUpdateWidget(covariant MyProgramsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadPrograms();
  }

  void _loadPrograms() {
    context.read<MyCourseBloc>().add(const GetEnrolledProgramEvent());
  }

  Future<void> _refreshPrograms() async {
    context.read<MyCourseBloc>().add(const RefreshEnrolledProgramEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); 
    
    return Scaffold(
      body: BlocConsumer<MyCourseBloc, MyCourseState>(
        listener: (context, state) {
          if (state is EnrolledProgramError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          
          if (state is EnrolledProgramLoading) {
            return ListView.builder(
              itemCount: state.fakePrograms.length,
              itemBuilder: (context, index) {
                return Skeletonizer(
                  child: ProgramCard(
                    programId: state.fakePrograms[index].program.id ?? '',
                    programName: state.fakePrograms[index].program.name ?? '',
                    batch: '',
                    programImage: state.fakePrograms[index].program.programImage ?? '',
                  ),
                );
              },
            );
          }
          
          if (state is EnrolledProgramLoaded) {
            final myPrograms = state.myPrograms;
            if (myPrograms.isEmpty) {
              return RefreshIndicator(
                onRefresh: _refreshPrograms,
                child: ListView(
                  children: const [
                    SizedBox(height: 100),
                    Center(child: Text('No programs found')),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: _refreshPrograms,
              child: ListView.builder(
                itemCount: myPrograms.length,
                itemBuilder: (context, index) {
                  final enrolledProgram = myPrograms[index];
                  final program = enrolledProgram.program;
                  final applicationState = enrolledProgram.applicationState;
                  
                  return ProgramCard(
                    programId: program.id ?? '',
                    programName: program.name ?? '',
                    batch: '',
                    programImage: program.programImage ?? '',
                    programStatus: ProgramStatus.fromApplicationStatus(applicationState),
                    program: program,
                  );
                },
              ),
            );
          }
          
          if (state is EnrolledProgramError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadPrograms,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          
         
          return const Center(child: LoadingWidget());
        },
      ),
    );
  }
}
