import 'package:flutter/material.dart';

class InformacionScreen extends StatelessWidget {
  const InformacionScreen({super.key});

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 16),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información sobre Donación'),
        backgroundColor: Colors.red.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('¿Por qué donar sangre?'),
            _buildInfoText(
                'La donación de sangre es un acto altruista que puede salvar vidas. La sangre y sus componentes son esenciales para tratamientos médicos y quirúrgicos, así como en situaciones de emergencia.'),
            const SizedBox(height: 16),
            _buildSectionTitle('Requisitos básicos para donar'),
            _buildInfoText(
                'Aunque los requisitos pueden variar ligeramente según la región, generalmente se necesita:'),
            _buildBulletPoint('Tener entre 18 y 65 años de edad.'),
            _buildBulletPoint('Pesar más de 50 kg.'),
            _buildBulletPoint('Gozar de buena salud general.'),
            _buildBulletPoint('No haber padecido enfermedades graves.'),
            _buildBulletPoint('No haber tenido comportamientos de riesgo.'),
            const SizedBox(height: 16),
            _buildSectionTitle('¿Qué tipos de sangre existen?'),
            _buildInfoText(
                'Los principales grupos sanguíneos son A, B, AB y O, y cada uno puede ser Rh positivo (+) o Rh negativo (-). La compatibilidad es crucial para las transfusiones.'),
            const SizedBox(height: 16),
            _buildSectionTitle('Proceso de donación'),
            _buildInfoText(
                'El proceso es rápido y seguro, y consta de varias etapas:'),
            _buildBulletPoint('Registro y cuestionario de salud.'),
            _buildBulletPoint('Entrevista médica y examen físico breve.'),
            _buildBulletPoint('Extracción de sangre (aproximadamente 10-15 minutos).'),
            _buildBulletPoint('Descanso y refrigerio post-donación.'),
            const SizedBox(height: 16),
            _buildSectionTitle('Beneficios de donar sangre'), 
            _buildInfoText(
                'Además de ayudar a quienes lo necesitan, donar sangre tiene beneficios para el donante:'),
            _buildBulletPoint('Puede reducir el riesgo de enfermedades cardíacas.'),
            _buildBulletPoint('Estimula la producción de nuevas células sanguíneas.'),  
            _buildBulletPoint('Proporciona un chequeo de salud gratuito.'),
            const SizedBox(height: 16),
            _buildSectionTitle('¿Dónde puedo donar?'),
            _buildInfoText(
                'Puedes donar en hospitales, centros de donación o campañas móviles. Consulta con tu centro local para más detalles.'),
            const SizedBox(height: 16),
            _buildSectionTitle('¿Cómo puedo ayudar más?'),
            _buildInfoText(
                'Además de donar sangre, puedes ayudar a crear conciencia sobre la importancia de la donación, organizar campañas o incluso ser voluntario en centros de donación.'),
          ],
        ),
      ),
    );
  }
}