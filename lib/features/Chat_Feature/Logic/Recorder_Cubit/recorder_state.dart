abstract class RecorderStates {}

class RecordStateToInit extends RecorderStates {}
class RecordStatesInit extends RecorderStates {}

/// Show Loader
class RecordStartLoading extends RecorderStates {}

/// Fetch story from source success
class StopRecordSuccess extends RecorderStates {
  String filePath;

  StopRecordSuccess({required this.filePath});
}

class ResetRecorder extends RecorderStates {}

class StartPlayerLoading extends RecorderStates {}
class StartPlayerFinish extends RecorderStates {}

class PauseAudioLoading extends RecorderStates {}
