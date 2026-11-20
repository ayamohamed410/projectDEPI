import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/theme/app_styles.dart';
import '../widgets/container.dart';

import '../../../../app/routes/route_screen_name.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../domain/entities/technician_profile_entity.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../bloc/profile/profile_state.dart';

class Sc22TechnicianProfile extends StatefulWidget {
  const Sc22TechnicianProfile({super.key});

  @override
  State<Sc22TechnicianProfile> createState() => _Sc22TechnicianProfileState();
}

int selectedindex = 0;

class _Sc22TechnicianProfileState extends State<Sc22TechnicianProfile> {
  @override
  void initState() {
    super.initState();
    selectedindex = 3; // Profile tab
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLogoutSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            RouteScreenName.loginScreen,
            (route) => false,
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(),

        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading || state is ProfileInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message, textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context
                          .read<ProfileBloc>()
                          .add(const ProfileRefreshed()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            final profile = (state as ProfileLoaded).profile;
            return _buildBody(context, profile);
          },
        ),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }


  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 62, 131, 215),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Technician Profile',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Row(
            children: [
              buildCustomContainer(
                cardColor: AppColors.colorbluew,
                child: Row(
                  children: const [
                    Icon(Icons.verified_outlined,
                        size: 20, color: AppColors.primary),
                    SizedBox(width: 4),
                    Text(
                      'PRO',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: IconButton(
                  icon: const Icon(Icons.person_outline,
                      color: Colors.white, size: 18),
                  onPressed: () => context
                      .read<ProfileBloc>()
                      .add(const ProfileRefreshed()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------- Body ----------------
  Widget _buildBody(BuildContext context, TechnicianProfileEntity p) {
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<ProfileBloc>().add(const ProfileRefreshed()),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              _headerCard(p),
              const SizedBox(height: 12),
              _aboutCard(p),
              const SizedBox(height: 8),
              _specialtiesCard(p),
              const SizedBox(height: 8),
              _coverageCard(p),
              _workingHoursCard(p),
              _ratesCard(p),
              _logoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerCard(TechnicianProfileEntity p) {
    return buildCustomContainer(
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.person, size: 60),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCustomContainer(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.workspace_premium,
                              size: 12, color: AppColors.primary),
                          SizedBox(width: 4),
                          Text(
                            'Elite Concierge Pro',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(p.name, style: AppTextStyles.sectionHeader),
                    Text(p.title, style: AppTextStyles.bodySmall),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text('${p.rating} ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                        Text('(${p.reviewsCount} reviews)',
                            style: AppTextStyles.bodySmall),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statBox('Experience', p.experience, 'Verified'),
              _statBox('Completed', '${p.completedJobs}', 'Total Jobs'),
              _statBox('Punctuality', '${p.punctuality}%', 'On-Time'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statBox(String caption, String value, String sub) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 6),
        decoration: BoxDecoration(
          color: AppColors.backgroundLightBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(caption, style: AppTextStyles.caption),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(value, style: AppTextStyles.priceText),
            ),
            Text(sub,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 10, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _aboutCard(TechnicianProfileEntity p) {
    return buildCustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.verified_user_outlined,
                  color: AppColors.primary, size: 18),
              SizedBox(width: 8),
              Text('About & Credentials', style: AppTextStyles.sectionHeader),
            ],
          ),
          const SizedBox(height: 8),
          Text(p.about,
              style: AppTextStyles.bodySmall,
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _specialtiesCard(TechnicianProfileEntity p) {
    return buildCustomContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.handyman_outlined,
                      color: AppColors.primary, size: 18),
                  SizedBox(width: 8),
                  Text('Core Specialties', style: AppTextStyles.sectionHeader),
                ],
              ),
              Text('${p.specialties.length} Certified'),
            ],
          ),
          Wrap(
            runSpacing: 8,
            spacing: 8,
            children: p.specialties
                .map((s) => buildCustomContainer(
                      cardColor: AppColors.bluenewcontainer,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.build_outlined,
                              color: AppColors.primary),
                          const SizedBox(width: 4),
                          Text(s, style: AppTextStyles.cardTitle),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _coverageCard(TechnicianProfileEntity p) {
    return buildCustomContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Icon(Icons.location_searching,
                      color: AppColors.primary, size: 18),
                  SizedBox(width: 8),
                  Text('Coverage Areas', style: AppTextStyles.sectionHeader),
                ],
              ),
              Text('Greater Cairo',
                  style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: p.coverageAreas
                .map((a) => buildCustomContainer(
                      cardColor: AppColors.bluenewcontainer,
                      child: Text(a),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _workingHoursCard(TechnicianProfileEntity p) {
    return buildCustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.access_time, color: AppColors.primary, size: 18),
              SizedBox(width: 8),
              Text('Working Hours & Availability',
                  style: AppTextStyles.sectionHeader),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(p.workingDays, style: AppTextStyles.cardTitle),
              Text(p.workingHours, style: AppTextStyles.bodySmall),
            ],
          ),
          if (p.emergencyAvailable) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: AppDecorations.infoBox,
              child: Row(
                children: const [
                  Icon(Icons.ac_unit, size: 14, color: AppColors.primary),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'Emergency 24/7 On-Call Dispatches Active',
                      style: TextStyle(
                          fontSize: 11,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _ratesCard(TechnicianProfileEntity p) {
    return buildCustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.payments_outlined,
                  color: AppColors.primary, size: 18),
              SizedBox(width: 8),
              Text('Standard Base Rates'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statBox('Inspection Visit',
                  'EGP ${p.inspectionFee.toStringAsFixed(0)}',
                  'Credited toward repair'),
              _statBox('Standard Labor',
                  'EGP ${p.hourlyRate.toStringAsFixed(0)} /hr',
                  'Official guaranteed rate'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _logoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkBanner,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        // يستخدم AuthBloc بتاع التيم (الموجود فوق الـ app في main.dart)
        onPressed: () =>
            context.read<AuthBloc>().add(const LogoutRequested()),
        icon: const Icon(Icons.edit_note, color: Colors.white),
        label: const Text(
          'log out',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ---------------- Bottom Nav ----------------
  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: AppColors.textSecondary,
      currentIndex: selectedindex,
      onTap: (val) {
        if (val == 3) return; // already on Profile
        const routes = {
          0: RouteScreenName.technicianDashboard,
          1: RouteScreenName.incomingRequests,
          2: RouteScreenName.jobsHistory,
        };
        Navigator.pushReplacementNamed(context, routes[val]!);
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined), label: 'Dashboard'),
        BottomNavigationBarItem(
            icon: Icon(Icons.mark_email_read_outlined), label: 'Requests'),
        BottomNavigationBarItem(
            icon: Icon(Icons.work_history_outlined), label: 'Jobs'),
        BottomNavigationBarItem(
            icon: Icon(Icons.badge_outlined), label: 'Profile'),
      ],
    );
  }
}
