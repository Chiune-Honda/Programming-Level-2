import SwiftUI

// MARK: - Entry Point
@main
struct WorkoutApp: App {
    var body: some Scene {
        WindowGroup {
            TabbedRootView()
    
        }
    }
}

struct MainScreenView: View {
    @Binding var workouts: [Workout]
    @State private var selectedDate = Date().stripTime()

    var body: some View {
        NavigationStack {
            VStack {
                CalendarView(selectedDate: $selectedDate, workouts: workouts)

                Divider()

                Text("Workouts on \(formattedDate(selectedDate))")
                    .font(.headline)
                    .padding()

                List {
                    ForEach(workoutsForSelectedDate(), id: \.id) { workout in
                        NavigationLink(destination: WorkoutDetailView(workout: workout, workouts: $workouts, dateFilter: selectedDate)) {
                            Text(workout.name)
                        }
                    }
                }
            }
            .navigationTitle("Workout Calendar")
        }
    }

    func workoutsForSelectedDate() -> [Workout] {
        workouts.filter { workout in
            if let exercises = workout.exercisesByDate[selectedDate], !exercises.isEmpty {
                return true
            }
            return false
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct CalendarView: View {
    @Binding var selectedDate: Date
    var workouts: [Workout]

    private let calendar = Calendar.current
    private let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    // Compute all days in current month for display
    private var daysInMonth: [Date] {
        guard let range = calendar.range(of: .day, in: .month, for: selectedDate) else { return [] }
        var dates: [Date] = []
        let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!

        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth) {
                dates.append(date)
            }
        }
        return dates
    }

    var body: some View {
        VStack(spacing: 5) {
            // Days of week labels
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day).frame(maxWidth: .infinity)
                }
            }

            // Calendar grid (7 columns)
            let firstWeekday = calendar.component(.weekday, from: daysInMonth.first ?? Date()) - 1
            let totalCells = daysInMonth.count + firstWeekday
            let rows = (totalCells / 7) + (totalCells % 7 > 0 ? 1 : 0)

            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<7, id: \.self) { column in
                        let index = row * 7 + column
                        if index < firstWeekday || index - firstWeekday >= daysInMonth.count {
                            Text(" ").frame(maxWidth: .infinity)
                        } else {
                            let date = daysInMonth[index - firstWeekday]
                            let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
                            let hasWorkout = workouts.contains { workout in
                                if let ex = workout.exercisesByDate[date.stripTime()], !ex.isEmpty {
                                    return true
                                }
                                return false
                            }

                            Button(action: {
                                selectedDate = date.stripTime()
                            }) {
                                Text("\(calendar.component(.day, from: date))")
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .background(isSelected ? Color.blue.opacity(0.7) : Color.clear)
                                    .cornerRadius(6)
                                    .overlay(
                                        Circle()
                                            .fill(Color.red)
                                            .frame(width: 6, height: 6)
                                            .opacity(hasWorkout ? 1 : 0)
                                            .offset(x: 12, y: -12)
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}



struct TabbedRootView: View {
    @State private var workouts: [Workout] = []
    @State private var selectedWorkout: Workout?

    var body: some View {
        TabView {
            MainScreenView(workouts: $workouts)
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            ContentView(workouts: $workouts, selectedWorkout: $selectedWorkout)
                .tabItem {
                    Label("Workouts", systemImage: "list.bullet")
                }
        }
    }
}


// MARK: - Models
struct Workout: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var exercisesByDate: [Date: [Exercise]] = [:]  // ✅ New structure
}


struct Exercise: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var sets: String = ""
    var reps: String = ""
}

// MARK: - Views
struct ContentView: View {
    @Binding var workouts: [Workout]
    @Binding var selectedWorkout: Workout?
    @State private var showAddWorkout = false
    
    


    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(workouts) { workout in
                        NavigationLink(destination: WorkoutDetailView(workout: workout, workouts: $workouts)) {
                            Text(workout.name)
                        }
                    }
                }

                Button(action: {
                    showAddWorkout = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle")
                        Text("Add New Workout")
                            .bold()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Workout Tracker")
            .toolbar {
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gear")
                }
            }
            .navigationDestination(isPresented: $showAddWorkout) {
                AddWorkoutView(workouts: $workouts, selectedWorkout: $selectedWorkout)
            }
        }
    }
}

struct WorkoutDetailView: View {
    var workout: Workout
    @Binding var workouts: [Workout]
    var dateFilter: Date? = nil

    @State private var selectedDate = Date().stripTime()
    @State private var newExercise = ""
    @State private var newSets = ""
    @State private var newReps = ""

    
    var filteredDate: Date {
          dateFilter ?? Date().stripTime()
      }
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .padding()

                let exercisesForDate = workouts.first(where: { $0.id == workout.id })?.exercisesByDate[selectedDate] ?? []

                List {
                    ForEach(Array(exercisesForDate.enumerated()), id: \.element.id) { index, ex in
                        HStack {
                            Text(ex.name).bold()
                            Spacer()

                            TextField("Sets", text: Binding(
                                get: { exercisesForDate[index].sets },
                                set: { newValue in
                                    updateExercise(for: workout.id, date: selectedDate, exerciseIndex: index) {
                                        $0.sets = newValue
                                    }
                                }
                            ))
                            .frame(width: 50)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                            TextField("Reps", text: Binding(
                                get: { exercisesForDate[index].reps },
                                set: { newValue in
                                    updateExercise(for: workout.id, date: selectedDate, exerciseIndex: index) {
                                        $0.reps = newValue
                                    }
                                }
                            ))
                            .frame(width: 50)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .padding(.vertical, 4)
                    }
                }

                HStack {
                    TextField("Exercise", text: $newExercise)
                    TextField("Sets", text: $newSets)
                        .frame(width: 50)
                    TextField("Reps", text: $newReps)
                        .frame(width: 50)
                    Button(action: addExercise) {
                        Image(systemName: "plus.circle")
                    }
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            }
            .navigationTitle(workout.name)
        }
    }

    func updateExercise(for workoutID: UUID, date: Date, exerciseIndex: Int, update: (inout Exercise) -> Void) {
        guard let workoutIndex = workouts.firstIndex(where: { $0.id == workoutID }) else { return }
        var exercisesForDate = workouts[workoutIndex].exercisesByDate[date] ?? []
        guard exercisesForDate.indices.contains(exerciseIndex) else { return }
        
        update(&exercisesForDate[exerciseIndex])
        workouts[workoutIndex].exercisesByDate[date] = exercisesForDate
    }

    func addExercise() {
        guard !newExercise.isEmpty, !newSets.isEmpty, !newReps.isEmpty else { return }
        if let workoutIndex = workouts.firstIndex(where: { $0.id == workout.id }) {
            var exercisesForDate = workouts[workoutIndex].exercisesByDate[selectedDate] ?? []
            exercisesForDate.append(Exercise(name: newExercise, sets: newSets, reps: newReps))
            workouts[workoutIndex].exercisesByDate[selectedDate] = exercisesForDate

            newExercise = ""
            newSets = ""
            newReps = ""
        }
    }
}




struct AddWorkoutView: View {
    @Binding var workouts: [Workout]
    @Binding var selectedWorkout: Workout?
    @Environment(\.dismiss) var dismiss
    @State private var workoutName = ""
    @State private var exercises: [Exercise] = [Exercise(name: "", sets: "", reps: "")]
    
    // Move filtering logic to a separate function or computed property
    private var cleanExercises: [Exercise] {
        exercises.filter { !$0.name.isEmpty }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Add New Workout")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                    
                    TextField("Workout name", text: $workoutName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    ForEach(exercises.indices, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text("Exercise \(index + 1)")
                                .font(.headline)
                            
                            TextField("Name", text: $exercises[index].name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .padding(.vertical, 4)
                    }
                    
                    Button(action: {
                        exercises.append(Exercise(name: "", sets: "", reps: ""))
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add Exercise")
                                .bold()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    Button("Create Workout") {
                        let today = Date().stripTime()
                        let newWorkout = Workout(name: workoutName, exercisesByDate: [today: cleanExercises])
                        workouts.append(newWorkout)
                        selectedWorkout = newWorkout
                        dismiss()
                    }
                    .disabled(workoutName.isEmpty)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(workoutName.isEmpty ? Color.gray.opacity(0.4) : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("New Workout")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

extension Date {
    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        return Calendar.current.date(from: components)!
    }
}

    
struct SettingsView: View {
    var body: some View {
        Text("Settings")
            .navigationTitle("Settings")
        }
    }

