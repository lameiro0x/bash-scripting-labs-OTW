# Linux & Security Fundamentals – Training Notes (Inspired by OverTheWire)

This repository contains my personal notes, commands, and small tools created while practicing Linux and basic security concepts using the OverTheWire wargames as inspiration.

⚠️ **No flags or level solutions are included.**
This repository focuses on **what I learned**, not on revealing answers.

---

## 📁 Repository Structure

```
bash-scripting-labs-OTW/
├── Notes.md                    # Concepts, commands, and lessons learned
└── Scripts/                    # Small utilities created during the labs
    ├── descompresor.sh
    └── procmon.sh
```

---

## 🧠 Notes (`Notes.md`)

This file contains:

- Linux commands practiced (filesystem, permissions, processes, pipes…)
- Explanations of how they work
- Real examples used during challenges
- Key takeaways related to security and system behavior

These notes serve as a reference for:

- CTF beginners
- Pentesting students
- Anyone learning Linux fundamentals

---

## 🛠 Included Scripts

### `descompresor.sh`
A helper script for **automating multi-layer decompression**.
Useful in challenges where files are compressed inside one another repeatedly (gzip, zip, bzip2…).

**Features:**
- Detects whether the extracted file is another compressed file
- Loops automatically until final content is reached
- Suppresses noisy output for clean processing

---

### `procmon.sh`
A simple real-time **process monitor**.
Compares the current list of processes against the previous one and shows only what **changed**.

Useful for observing:

- ephemeral processes
- processes spawned by SUID binaries
- unexpected activity in training environments

---

## ⚖️ Ethical Note

These materials were created for **learning Linux and security principles**, not to distribute solutions or walkthroughs of OverTheWire challenges.
