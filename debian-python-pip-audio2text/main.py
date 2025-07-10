from fastapi import FastAPI, File, UploadFile
import whisper
import os
import shutil
import subprocess

app = FastAPI()
model = whisper.load_model("medium")  # Use "medium" for better Spanish support

def convert_to_wav(input_path: str, output_path: str):
    subprocess.run([
        "ffmpeg", "-y", "-i", input_path, "-ar", "16000", "-ac", "1", output_path
    ], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

@app.post("/transcribe")
async def transcribe_audio(file: UploadFile = File(...)):
    temp_dir = "/tmp/audio"
    os.makedirs(temp_dir, exist_ok=True)

    if not file.filename.endswith((".mp3", ".wav", ".ogg", ".m4a")):
        return {"error": "Unsupported file type"}

    original_path = os.path.join(temp_dir, file.filename)
    with open(original_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    wav_path = os.path.join(temp_dir, "converted.wav")
    convert_to_wav(original_path, wav_path)

    result = model.transcribe(wav_path, language="es")

    os.remove(original_path)
    os.remove(wav_path)

    return {"text": result["text"]}
