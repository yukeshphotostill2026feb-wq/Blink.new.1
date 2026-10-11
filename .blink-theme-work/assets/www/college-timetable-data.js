(() => {
  const courses = Object.freeze({
    BT521: {
      courseCode: '21BT521',
      courseName: 'Genetic Engineering',
      type: 'Theory',
      faculty: 'Dr. J. Bindhu, HOD/BT',
      credits: 4,
      hours: 5,
    },
    BT522: {
      courseCode: '21BT522',
      courseName: 'Bioprocess Engineering',
      type: 'Theory',
      faculty: 'Ms. Akshaya A, AP/BT',
      credits: 4,
      hours: 5,
    },
    BT501: {
      courseCode: '21BT501',
      courseName: 'Marine Biotechnology',
      type: 'Theory',
      faculty: 'Ms. K. Geethanjali, AP/BT',
      credits: 3,
      hours: 5,
    },
    BT502: {
      courseCode: '21BT502',
      courseName: 'Instrumental Method of Analysis',
      type: 'Theory',
      faculty: 'Dr. S. Harilakshmi, AP/BT',
      credits: 3,
      hours: 5,
    },
    PBT16: {
      courseCode: '21PBT16',
      courseName: 'Separation Technique',
      type: 'Theory',
      faculty: 'Mrs. Vinitha AP / BT',
      credits: 3,
      hours: 5,
    },
    PBT11: {
      courseCode: '21PBT11',
      courseName: 'Industrial Food Processing',
      type: 'Theory',
      faculty: 'Dr. S. Ramya, AP/BT',
      credits: 3,
      hours: 5,
    },
    BT511: {
      courseCode: '21BT511',
      courseName: 'Engineering Exploration V',
      type: 'Project',
      faculty: 'All faculties',
      credits: 2,
      hours: 9,
    },
    EN501: {
      courseCode: '21EN501',
      courseName: 'Career Enhancement Program',
      type: 'Professional development',
      faculty: 'Ms. Raji & Mrs. Nechara',
      credits: 1,
      hours: 4,
    },
  });

  let sequence = 0;
  const slot = (day, startTime, endTime, courseId, options = {}) => ({
    id: `${day.toLowerCase()}-${++sequence}`,
    day,
    startTime,
    endTime,
    courseId,
    kind: options.kind || 'class',
    location: options.location || '',
    isLab: Boolean(options.isLab),
    label: options.label || '',
    allDay: Boolean(options.allDay),
  });
  const classSlot = (day, start, end, courseId, options) =>
    slot(day, start, end, courseId, options);
  const breakSlot = (day, start, end, kind = 'break', label = '') =>
    slot(day, start, end, '', { kind, label });

  const schedule = [
    classSlot('Monday', '08:30', '09:15', 'BT502', { location: 'LH 30' }),
    classSlot('Monday', '09:15', '10:00', 'BT521', { location: 'LH 30' }),
    classSlot('Monday', '10:00', '10:45', 'BT501', { location: 'LH 30' }),
    breakSlot('Monday', '10:45', '11:00'),
    classSlot('Monday', '11:00', '11:45', 'PBT16', { location: 'LH 30' }),
    classSlot('Monday', '11:45', '12:30', 'PBT11', { location: 'LH 30' }),
    classSlot('Monday', '12:30', '13:15', 'BT521', { location: 'LH 30' }),
    breakSlot('Monday', '13:15', '14:00', 'lunch'),
    classSlot('Monday', '14:00', '14:45', 'BT501', { location: 'LH 30' }),
    classSlot('Monday', '14:45', '15:30', 'BT502', { location: 'LH 30' }),
    breakSlot('Monday', '15:30', '15:45'),
    classSlot('Monday', '15:45', '16:30', 'PBT11', { location: 'LH 30' }),

    classSlot('Tuesday', '08:30', '09:15', 'BT521', { location: 'LH 30' }),
    classSlot('Tuesday', '09:15', '10:00', 'BT521', { location: 'LH 30' }),
    classSlot('Tuesday', '10:00', '10:45', 'BT502', { location: 'LH 30' }),
    breakSlot('Tuesday', '10:45', '11:00'),
    classSlot('Tuesday', '11:00', '11:45', 'PBT11', { location: 'LH 30' }),
    classSlot('Tuesday', '11:45', '12:30', 'BT522', { location: 'LH 30' }),
    classSlot('Tuesday', '12:30', '13:15', 'BT521', { isLab: true }),
    breakSlot('Tuesday', '13:15', '14:00', 'lunch'),
    classSlot('Tuesday', '14:00', '15:30', 'BT521', { isLab: true }),
    breakSlot('Tuesday', '15:30', '15:45'),
    breakSlot('Tuesday', '15:45', '16:30', 'free', 'No class'),

    classSlot('Wednesday', '08:30', '09:15', 'BT522', { location: 'LH 30' }),
    classSlot('Wednesday', '09:15', '10:00', 'BT521', { location: 'LH 30' }),
    classSlot('Wednesday', '10:00', '10:45', 'BT522', { location: 'LH 30' }),
    breakSlot('Wednesday', '10:45', '11:00'),
    classSlot('Wednesday', '11:00', '11:45', 'BT502', { location: 'LH 30' }),
    classSlot('Wednesday', '11:45', '12:30', 'BT501', { location: 'LH 30' }),
    classSlot('Wednesday', '12:30', '13:15', 'BT522', { location: 'LH 30' }),
    breakSlot('Wednesday', '13:15', '14:00', 'lunch'),
    classSlot('Wednesday', '14:00', '14:45', 'PBT16', { location: 'LH 30' }),
    classSlot('Wednesday', '14:45', '15:30', 'BT502', { location: 'LH 30' }),
    breakSlot('Wednesday', '15:30', '15:45'),
    classSlot('Wednesday', '15:45', '16:30', 'BT501', { location: 'LH 30' }),

    classSlot('Thursday', '08:30', '10:00', 'EN501', {
      location: 'Seminar Hall 1',
      label: 'Verbal',
    }),
    classSlot('Thursday', '10:00', '10:45', 'PBT16', { location: 'LH 30' }),
    breakSlot('Thursday', '10:45', '11:00'),
    classSlot('Thursday', '11:00', '11:45', 'BT502', { location: 'LH 30' }),
    classSlot('Thursday', '11:45', '12:30', 'BT522', { location: 'LH 30' }),
    classSlot('Thursday', '12:30', '13:15', 'BT522', { isLab: true }),
    breakSlot('Thursday', '13:15', '14:00', 'lunch'),
    classSlot('Thursday', '14:00', '15:30', 'BT522', { isLab: true }),
    breakSlot('Thursday', '15:30', '15:45'),
    breakSlot('Thursday', '15:45', '16:30', 'free', 'No class'),

    classSlot('Friday', '08:30', '09:15', 'BT521', { location: 'LH 30' }),
    classSlot('Friday', '09:15', '10:00', 'PBT16', { location: 'LH 30' }),
    classSlot('Friday', '10:00', '11:00', 'EN501', {
      location: 'Seminar Hall 1',
      label: 'Quants',
    }),
    breakSlot('Friday', '11:00', '11:45', 'break', 'Break / transition'),
    classSlot('Friday', '11:45', '12:30', 'BT501', { location: 'LH 30' }),
    classSlot('Friday', '12:30', '13:15', 'PBT11', { location: 'LH 30' }),
    breakSlot('Friday', '13:15', '14:00', 'lunch'),
    classSlot('Friday', '14:00', '14:45', 'BT522', { location: 'LH 30' }),
    classSlot('Friday', '14:45', '15:30', 'PBT11', { location: 'LH 30' }),
    breakSlot('Friday', '15:30', '15:45'),
    classSlot('Friday', '15:45', '16:30', 'PBT16', { location: 'LH 30' }),

    slot('Saturday', '', '', 'BT511', {
      kind: 'project',
      label: 'Project Progress Review',
      allDay: true,
    }),
  ];

  window.BLINK_COLLEGE_TIMETABLE = Object.freeze({
    college: 'Sri Shakthi Institute of Engineering and Technology',
    department: 'Department of Biotechnology',
    academicYear: '2026–27 (ODD)',
    yearAndSemester: 'III & V',
    classroom: 'LH 30',
    classAdvisor: 'Mrs. Vinitha AP / BT',
    days: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
    courses,
    schedule,
  });
})();
