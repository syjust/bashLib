# pip install SpeechRecognition pydub
import sys
import os
import math
import speech_recognition as sr
from pydub import AudioSegment

def get_unique_output_path(base_path):
    """Génère un chemin de fichier unique pour éviter les collisions."""
    output_txt_path = base_path + ".txt"
    counter = 1
    while os.path.exists(output_txt_path):
        output_txt_path = f"{base_path}_{counter}.txt"
        counter += 1
    return output_txt_path

def transcribe_mp3(mp3_path):
    if not os.path.isfile(mp3_path):
        print(f"[Erreur] Fichier introuvable : {mp3_path}")
        sys.exit(1)

    # Définir chemins
    base_path = os.path.splitext(mp3_path)[0]
    wav_path = base_path + ".wav"
    output_txt_path = get_unique_output_path(base_path)

    # Convertir MP3 -> WAV si nécessaire
    if os.path.isfile(wav_path):
        print("[Info] Fichier WAV trouvé, conversion sautée.")
    else:
        print("[Info] Fichier WAV introuvable, conversion en cours...")
        audio = AudioSegment.from_mp3(mp3_path)
        audio = audio.set_channels(1)          # Mono
        audio = audio.set_frame_rate(16000)     # 16 kHz
        audio.export(wav_path, format="wav")
        print("[Info] Conversion MP3 -> WAV terminée.")

    # Charger l'audio WAV
    audio = AudioSegment.from_wav(wav_path)
    duration_milli_seconds = len(audio)
    duration_seconds = duration_milli_seconds / 1000  # Durée en secondes
    num_chunks = math.ceil(duration_seconds / 60)

    recognizer = sr.Recognizer()

    print(f"[Info] Début de la transcription ({num_chunks} morceau(x) de 60 secondes, durée totale : {int(duration_seconds)} secondes).")

    with open(output_txt_path, "w", encoding="utf-8") as f:
        # TODO: fix the last chunck processing => it should start from 0 - not from 1
        # [Info] Fichier WAV trouvé, conversion sautée.
        # [Info] Début de la transcription (12 morceau(x) de 60 secondes, durée totale : 668 secondes).
        # [Info] Traitement du morceau 1/12... #should be (0_000:60_000) ... but maybe is (60_000:120_000)
        # [Info] Traitement du morceau 2/12...
        # [Info] Traitement du morceau 3/12...
        # [Info] Traitement du morceau 4/12...
        # [Info] Traitement du morceau 5/12...
        # [Info] Traitement du morceau 6/12...
        # [Info] Traitement du morceau 7/12...
        # [Info] Traitement du morceau 8/12...
        # [Info] Traitement du morceau 9/12...
        # [Info] Traitement du morceau 10/12...
        # [Info] Traitement du morceau 11/12...
        # [Info] Traitement du morceau 12/12... #should be (660_000:668_000) ... but maybe is (660_000:720_000)
        # Traceback (most recent call last):
        #   File "./mp3-to-txt.py", line 61, in transcribe_mp3
        #     part_text = recognizer.recognize_google(audio_data, language="fr-FR")
        #   File "$HOME/miniconda3/lib/python3.9/site-packages/speech_recognition/recognizers/google.py", line 262, in recognize_legacy
        #     return output_parser.parse(response_text)
        #   File "$HOME/miniconda3/lib/python3.9/site-packages/speech_recognition/recognizers/google.py", line 134, in parse
        #     actual_result = self.convert_to_result(response_text)
        #   File "$HOME/miniconda3/lib/python3.9/site-packages/speech_recognition/recognizers/google.py", line 183, in convert_to_result
        #     raise UnknownValueError()
        # speech_recognition.exceptions.UnknownValueError
        # 
        # During handling of the above exception, another exception occurred:
        # 
        # Traceback (most recent call last):
        #   File "./mp3-to-txt.py", line 79, in <module>
        #     transcribe_mp3(mp3_file)
        #   File "./mp3-to-txt.py", line 65, in transcribe_mp3
        #     raise Exception(f"[Erreur] Reconnaissance impossible sur le morceau {i+1}/{num_chunks}.")
        # Exception: [Erreur] Reconnaissance impossible sur le morceau 12/12.
        for i in range(num_chunks):

            start_ms = i * 60_000
            end_ms = min((i + 1) * 60_000, duration_milli_seconds)

            print(f"[Info] Traitement du morceau {i+1}/{num_chunks} [{start_ms}:{end_ms}]...")
            chunk = audio[start_ms:end_ms]

            chunk_wav_path = f"{base_path}_chunk_{i}.wav"
            chunk.export(chunk_wav_path, format="wav")

            with sr.AudioFile(chunk_wav_path) as source:
                audio_data = recognizer.record(source)

            try:
                part_text = recognizer.recognize_google(audio_data, language="fr-FR")
                f.write(part_text + "\n\n")
                f.flush()  # Forcer l'écriture disque immédiatement
            except sr.UnknownValueError:
                raise Exception(f"[Erreur] Reconnaissance impossible sur le morceau {i+1}/{num_chunks}.")
            except sr.RequestError as e:
                raise Exception(f"[Erreur] Service de reconnaissance échoué sur le morceau {i+1}/{num_chunks} : {e}")
            finally:
                os.remove(chunk_wav_path)

    print(f"[Succès] Transcription terminée : {output_txt_path}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Utilisation : python {sys.argv[0]} chemin_du_fichier.mp3")
        sys.exit(1)

    mp3_file = sys.argv[1]
    transcribe_mp3(mp3_file)

