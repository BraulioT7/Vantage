import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'ghost_sync_step_screen.dart';


/// Modelo de datos para un paso de entrenamiento actualizado con consejo
class DrillStep {
  final String text;
  final String videoUrl;
  final String ghostTarget;
  final String coachAdvice; // Nuevo campo para el consejo dinámico


  DrillStep({
    required this.text,
    required this.videoUrl,
    required this.ghostTarget,
    required this.coachAdvice,
  });
}


class DrillDetailScreen extends StatefulWidget {
  final String title;
  final String heroName;
  final List<DrillStep> steps;


  const DrillDetailScreen({
    super.key,
    required this.title,
    required this.heroName,
    required this.steps,
  });


  @override
  State<DrillDetailScreen> createState() => _DrillDetailScreenState();
}


class _DrillDetailScreenState extends State<DrillDetailScreen> {
  int _currentStepIndex = 0;


  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }


  void _completeStep(int index) {
    if (index == _currentStepIndex) {
      setState(() {
        if (_currentStepIndex < widget.steps.length) {
          _currentStepIndex++;
        }
      });
    }
  }


  // Nueva función para regresar al paso anterior
  void _previousStep() {
    if (_currentStepIndex > 0) {
      setState(() {
        _currentStepIndex--;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    bool allCompleted = _currentStepIndex >= widget.steps.length;
    int displayIndex = _currentStepIndex < widget.steps.length
        ? _currentStepIndex
        : widget.steps.length - 1;


    return Scaffold(
      backgroundColor: VantageColors.obsidian,
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: Image.network(
                widget.steps[displayIndex].videoUrl,
                key: ValueKey(_currentStepIndex),
                fit: BoxFit.cover,
                height: double.infinity,
                opacity: const AlwaysStoppedAnimation(0.4),
                errorBuilder: (context, error, stackTrace) => Container(color: Colors.black),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildTopBar(),
                const Spacer(),
                _buildInfoPanel(allCompleted),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.white, size: 28),
          ),
          // Botón opcional para regresar paso desde la barra si no se terminó
          if (_currentStepIndex > 0)
            TextButton.icon(
              onPressed: _previousStep,
              icon: const Icon(Icons.history, color: Colors.white60, size: 16),
              label: const Text("PASO ANTERIOR", style: TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }


  Widget _buildInfoPanel(bool allCompleted) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.3, 1.0],
          colors: [Colors.transparent, VantageColors.obsidian, VantageColors.obsidian],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.heroName.toUpperCase(), style: const TextStyle(color: VantageColors.neonMint, fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 12)),
          const SizedBox(height: 4),
          Text(widget.title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, height: 1.1)),
          const SizedBox(height: 24),
          const Text("PROGRESO DE LA TÉCNICA", style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 12),
          ...List.generate(widget.steps.length, (index) {
            bool isLocked = index > _currentStepIndex;
            bool isDone = index < _currentStepIndex;
            bool isActive = index == _currentStepIndex;
            return _buildStepTile(index, isLocked, isDone, isActive);
          }),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: allCompleted ? () => Navigator.pop(context) : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: allCompleted ? VantageColors.neonMint : Colors.white10,
                    foregroundColor: Colors.black,
                  ),
                  child: Text(allCompleted ? "SESIÓN FINALIZADA" : "COMPLETA LOS PASOS"),
                ),
              ),
              if (!allCompleted) ...[
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GhostSyncStepScreen(
                        stepNumber: _currentStepIndex + 1,
                        targetMetric: widget.steps[_currentStepIndex].ghostTarget,
                        coachAdvice: widget.steps[_currentStepIndex].coachAdvice, // Pasamos el consejo
                      ),
                    ),
                  ),
                  child: Container(
                    height: 50, width: 50,
                    decoration: BoxDecoration(
                      color: VantageColors.electricViolet.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: VantageColors.electricViolet),
                    ),
                    child: const Icon(Icons.visibility, color: VantageColors.electricViolet, size: 20),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildStepTile(int index, bool isLocked, bool isDone, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (isActive) _completeStep(index);
        // Si el usuario toca un paso anterior ya hecho, le permitimos "regresar" a ese punto
        if (isDone) {
          setState(() {
            _currentStepIndex = index;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withOpacity(0.05) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isActive ? VantageColors.neonMint.withOpacity(0.4) : Colors.transparent),
        ),
        child: Row(
          children: [
            Icon(
              isDone ? Icons.check_circle : (isLocked ? Icons.lock_outline : Icons.play_circle_outline),
              color: isDone ? VantageColors.neonMint : (isActive ? Colors.white : Colors.white24),
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "Paso ${index + 1}: ${widget.steps[index].text}",
                style: TextStyle(
                  color: isLocked ? Colors.white24 : (isDone ? Colors.white38 : Colors.white),
                  fontSize: 13,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  decoration: isDone ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            // Indicador de que se puede "regresar"
            if (isDone)
              const Icon(Icons.refresh, color: Colors.white24, size: 14),
          ],
        ),
      ),
    );
  }
}
